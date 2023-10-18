package com.himedia.springboot;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class mainController { 
	@Autowired
	private travel_attDAO tdao;
	@Autowired
	private BoardDAO bdao;
	@Autowired
	private CommentDAO cdao;
	@Autowired
	private ReplyDAO rdao;
	
	
	@GetMapping("/")
	public String home(HttpServletRequest req, Model model) {
		HttpSession s = req.getSession();
		String email = (String) s.getAttribute("id");
		
		
		ArrayList<travel_attDTO> alemp = tdao.locationName();
		ArrayList<BoardDTO> alemp2 = bdao.getboardlist();
		ArrayList<travel_attDTO> alemp3 = tdao.foodStore();
		ArrayList<travel_attDTO> alemp4 = tdao.shopping();
		ArrayList<travel_attDTO> alemp5 = tdao.hotel();
		
		model.addAttribute("hotel",alemp5);
		model.addAttribute("shopping",alemp4);
		model.addAttribute("food",alemp3);
		model.addAttribute("location",alemp);
		model.addAttribute("id",email);
		model.addAttribute("board",alemp2);
		
		return "home";
	}
	

	
	
	@GetMapping("/q&a")
	public String showqanda(HttpServletRequest req, Model model) {
		
		
		HttpSession session = req.getSession();
		String member_Id = (String) session.getAttribute("member_Id");
		model.addAttribute("member_Id", member_Id);
		if(member_Id==null || member_Id.equals("")) {
			
			model.addAttribute("member_Id","");
			
		}
		else {
			
			model.addAttribute("member_Id",(String) session.getAttribute("member_Id"));
		}
		
		
			
		
		int start,psize,pno;
		String page = req.getParameter("pageno");
		if(page==null||page.equals("")) {
			pno=1;
		} else {
			pno = Integer.parseInt(page);
		}
		
		start = (pno-1)*10;
		psize=10;
		ArrayList<BoardDTO> alBoard = bdao.getList(start, psize);
		
		
		int cnt=bdao.getTotal();
		int pagecount = (int)Math.ceil(cnt/10.0); // pagecount = 3 
		System.out.println("pagecount="+pagecount);
		
	
		String pagestr="";
		for(int i=1; i<=pagecount; i++) { 
			if(pno==i) {
				pagestr +=i+"&nbsp";
			} else {
			pagestr+="<a href='/q&a?pageno="+i+"'>"+i+"</a>&nbsp";
			}
		}
		model.addAttribute("pagestr",pagestr);
		
		
		
		 ArrayList<BoardDTO> popularPosts = bdao.popular();
		 model.addAttribute("popularPosts", popularPosts);
	

		model.addAttribute("blist",alBoard);
		return "q&a";
	}
	
	
	@GetMapping("/view")
	public String view(HttpServletRequest req, Model model) {
	    HttpSession session = req.getSession();

	    // 게시글 번호
	    int seqno = Integer.parseInt(req.getParameter("seqno"));
	    BoardDTO bdto = bdao.view(seqno);
	    bdao.hitup(seqno);
	    model.addAttribute("bpost", bdto);

	    // 댓글 조회
	    int boardSeqno = Integer.parseInt(req.getParameter("seqno"));
	    ArrayList<CommentDTO> comments = cdao.showComment(boardSeqno);

	   
	    model.addAttribute("comments", comments);

	
	    model.addAttribute("commenter", session.getAttribute("id"));
	    model.addAttribute("comment_content", "");
	    
	    // 답글
	    
	   
	    

	    return "view"; 
	}

	
	
	
	
	
	@PostMapping("/doincomment")
    public String docomment(HttpServletRequest req, Model model) {
        HttpSession session = req.getSession();
        String commenter = (String) session.getAttribute("id");
        
      

        // 댓글 작성
        int boardSeqno = Integer.parseInt(req.getParameter("board_seqno"));
        String commentContent = req.getParameter("comment_content");
        int isprivate = Integer.parseInt(req.getParameter("isprivate"));
        
        int isprivatecomment = 0; 
        String isprvc = req.getParameter("isprivatecomment");
        
        if(isprvc !=null && !isprvc.isEmpty()) {
        	isprivatecomment = Integer.parseInt(isprvc);
        }
        
        int result = cdao.addComment(commenter, commentContent, boardSeqno, isprivate, isprivatecomment);

        if (result == 1) {
            
            return "redirect:/view?seqno=" + boardSeqno;
        } else {
            model.addAttribute("error", "댓글 추가에 실패했습니다.");
            return "redirect:/q&a";
        }
    }
	
	

	@GetMapping("/write")
	public String write() {
		return "write";
	}
	
	
	
	
	@PostMapping("/insert")
	public String insert(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String title=req.getParameter("title");
		String content=req.getParameter("content");
		String writer = (String) session.getAttribute("id");
		String category = req.getParameter("category");
		
		String prv = req.getParameter("private");
		int isprivate = 0;
		
		if(prv != null && prv.equals("on")) {
			isprivate = 1;
		}
		
		
		System.out.println("isprivate" + isprivate);
		 System.out.println("Title: " + title);
		    System.out.println("Content: " + content);
		    System.out.println("Writer: " + writer);
		    System.out.println("Category: " + category);
		
		
		
		
		bdao.insert(title,content,writer,category,isprivate);
		return "redirect:/q&a";
	}
	
	
	
	
	@PostMapping("/deletePost")
	public String deletePost(HttpServletRequest req, Model model) {
	    HttpSession session = req.getSession();
	    

	    String id = (String) session.getAttribute("id");
	    if (id == null) {
	        model.addAttribute("error", "로그인 후 게시글을 삭제할 수 있습니다.");
	        return "redirect:/q&a";
	    }
	    
	    int seqno = Integer.parseInt(req.getParameter("seqno"));
	    
	    // 대댓글 먼저 삭제 => 댓글 먼저 삭제시 대댓글 삭제X
	    rdao.deleteByPost(seqno);
	    // 게시글 삭제시, 댓글도 삭제
	    cdao.deleteByboard(seqno);
	    
	    
	    // 게시글 작성자와 로그인한 사용자가 같은지 확인
	    BoardDTO bdto = bdao.view(seqno);
	    if (bdto.getWriter().equals(id)) {
	        // 게시글 삭제 수행
	        bdao.deletePost(seqno);
	    } else {
	        model.addAttribute("error", "게시글 작성자만 게시글을 삭제할 수 있습니다.");
	    }
	    
	    return "redirect:/q&a";
	}

	
	
	
	@PostMapping("/editComment")
	public String editComment(@RequestParam("content") String comment_content,
	                          @RequestParam("commentId") int comment_id,
	                          @RequestParam("board_seqno") int board_seqno,
	                          Model model) {
	    
	    cdao.editComment(board_seqno, comment_content, comment_id); 

	    System.out.println(comment_content);
	    
	    return "redirect:/view?seqno=" + board_seqno;
	}



	
	
	
	
	@PostMapping("/editPost")
	public String editPost(HttpServletRequest req, Model model) {
	    HttpSession session = req.getSession();
	      
	    
	    int seqno = Integer.parseInt(req.getParameter("seqno"));
	    String title = req.getParameter("title");
	    String content = req.getParameter("content");
	    String category = req.getParameter("category");
	    
	    
	    BoardDTO bdto = bdao.view(seqno);
	  
	        // 게시글 수정 수행
	        bdao.editPost(seqno, title, content, category);
	
	    return "redirect:/q&a";
	}
	
	
	
	@PostMapping("/edtrply")
	public ResponseEntity<String> editreplies(@RequestParam("reply_id") int replyId,
	                                          @RequestParam("reply_content") String reply_content,
	                                          Model model) {
	    rdao.edtreply(replyId, reply_content); 

	    System.out.println(reply_content);
	    System.out.println(replyId);
	    
	    
	  
	    return ResponseEntity.ok("1");
	}

	@PostMapping("/delrply")
	public ResponseEntity<String> editreplies(@RequestParam("reply_id") int replyId,
												Model model) {
		rdao.delete(replyId);
		
		System.out.println(replyId);
		
		 return ResponseEntity.ok("1");
	}
	
	
	
	

	
	
	
	@PostMapping("/deleteComment")
	public String deleteComments(HttpServletRequest req) {
		 HttpSession session = req.getSession();
		 
		 int board_seqno = Integer.parseInt(req.getParameter("seqno"));
		 int comment_id = Integer.parseInt(req.getParameter("commentId"));
		 
		 
		 rdao.deleteByComment(comment_id);
		 
		 // 댓글 삭제시, 답글도 삭제 
		 rdao.delete(comment_id);
		  
		 cdao.deleteComment(board_seqno,comment_id);
		 
		 return "redirect:/view?seqno=" + board_seqno;
	}
	
	
	
	
	
	@PostMapping("/saveCommentCount")
	public String savecmt(HttpServletRequest req) {
		 HttpSession session = req.getSession();
		 
		 int seqno = Integer.parseInt(req.getParameter("seqno"));
		 int answer_count = Integer.parseInt(req.getParameter("commentCount"));
		  
		 bdao.answerCount(seqno, answer_count);
		 
		 return "";
	}

	
	
	@PostMapping("/getReplies")
	@ResponseBody
	public List<ReplyDTO> getReplies(HttpServletRequest req,Model model) {
	    HttpSession session = req.getSession();

	    int parent_comment_id = Integer.parseInt(req.getParameter("commentId"));
	    
	    List<ReplyDTO> replies = rdao.showreply(parent_comment_id);
	    
	    model.addAttribute("replies",replies);

	    return replies;
	}


	
	
	// 답글 (대댓글) 작성 
	@PostMapping("/doinreply")
	@ResponseBody
	public String doreply(HttpServletRequest req) {
	    HttpSession session = req.getSession();
	    String commenter = req.getParameter("commenter");
	    String reply_content = req.getParameter("replyContent");
	    int parent_comment_id = Integer.parseInt(req.getParameter("commentId"));
	    
	    int isprivate = 0;
	    String isprv = req.getParameter("isprivate");
	    
	    if(isprv !=null && !isprv.isEmpty()) {
	    	isprivate = Integer.parseInt(isprv);
	    }
	    
 
	    int n = rdao.addReply(commenter, reply_content, parent_comment_id, isprivate);
	    
	    System.out.println(isprivate);

	    if (n == 1) {
	        return ""; // 빈 문자열을 반환
	    } else {
	        return "errorrrrrrr"; 
	    }
	}

	
}