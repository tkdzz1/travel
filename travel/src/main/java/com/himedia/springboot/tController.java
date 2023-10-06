package com.himedia.springboot;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class tController {
	@Autowired
	private travel_attDAO tdao;
	@Autowired
	private reviewDAO rdao;
	@Autowired
	private cartDAO cdao;
	@Autowired
	private likeDAO ldao;
	
	@GetMapping("/travel_list")
	public String tlist(HttpServletRequest req,Model model) {
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=tdao.cntTravelList("관광지");
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/travel_list?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<travel_attDTO> getlist = tdao.getList(start,psize,"관광지");
		model.addAttribute("list", getlist);	
		return "travel_attraction/travel_list";
	}
	
	@GetMapping("/add_TravelList")
	public String addlist() {
		return "travel_attraction/add_list";
	}
	
	@Value("${mainimage.directory}")
	private String mainuploadDirectory;
	@Value("${detailimage.directory}")
	private String detailuploadDirectory;
    @PostMapping("/upload")
    public String uploadFile(@RequestParam("image") MultipartFile main,
                             @RequestParam("imageFiles") MultipartFile[] detailImages,
                             @RequestParam("imginfo") String[] detailInfos,
                             HttpServletRequest req,
                             Model model) {
        if (!main.isEmpty()) {
            try {
                // 메인 이미지 추가
                String name = req.getParameter("name");
                String local = req.getParameter("local");
                String image = main.getOriginalFilename();
                String address = req.getParameter("address");
                String category = req.getParameter("category");
                
                String[] cList = {"관광지", "travel_list", "음식", "food_store", "숙박", "stay", "쇼핑", "shopping"};
                String redirect = "";
                
                for (int i=0; i<cList.length; i+=2) {
                	if (category.equals(cList[i])) {
                		redirect = cList[i+1];
                	}
                }
                
                double latitude = Double.parseDouble(req.getParameter("latitude"));
                double longitude = Double.parseDouble(req.getParameter("longitude"));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
                Date date = new Date();
                String formattedDate = sdf.format(date);
                String fileExtension = StringUtils.getFilenameExtension(image);
                UUID mainId = UUID.randomUUID();
                String savedMainName = mainId.toString() + formattedDate + "." + fileExtension;
                File mainFile = new File(mainuploadDirectory + File.separator + savedMainName);
                main.transferTo(mainFile);

                // 디테일 이미지들을 "/"로 구분하여 저장
                StringBuilder detailImagePaths = new StringBuilder();
                for (MultipartFile detailImage : detailImages) {
                    if (!detailImage.isEmpty()) {
                        String detailImageName = detailImage.getOriginalFilename();
                        // 디테일 이미지 파일 저장 및 경로 추가
                        UUID detailImageId = UUID.randomUUID();
                        String savedDetailImageName = detailImageId.toString() + formattedDate + "." + StringUtils.getFilenameExtension(detailImageName);
                        File detailImageFile = new File(detailuploadDirectory + File.separator + savedDetailImageName);
                        detailImage.transferTo(detailImageFile);
                        if (detailImagePaths.length() > 0) {
                            detailImagePaths.append("/");
                        }
                        detailImagePaths.append(savedDetailImageName);
                    } else {	
                    	detailImagePaths.append("/");
                    }
                }
                StringBuilder taContentBuilder = new StringBuilder();
                for (String detailInfo : detailInfos) {
	                    if (detailInfo == null || detailInfo.isEmpty()) {
	                        // 콘텐츠가 비어있는 경우 더미 데이터를 추가합니다
	                    	
	                        taContentBuilder.append("/");
	                    } else {
	                        if (taContentBuilder.length() > 0) {
		                    	taContentBuilder.append("/");
		                        taContentBuilder.append(detailInfo);
	                        } else {
	                        	taContentBuilder.append(detailInfo);
	                        }
	                    }
                }
                
                String taContent = taContentBuilder.toString();
                // 여행지 정보를 데이터베이스에 저장
                tdao.addTravelList(name, local, savedMainName, address, category, latitude, longitude);
                tdao.addImgInfo(name,detailImagePaths.toString(),taContent);
                model.addAttribute("fileName", mainFile);
                return "redirect:/" + redirect;
            } catch (IOException e) {
                e.printStackTrace();
                model.addAttribute("errorMessage", "파일 업로드 실패");
            }
        } else {
            model.addAttribute("errorMessage", "업로드할 메인 이미지 파일을 선택하세요.");
        }

        return "redirect:/travel_list";
    }

    @PostMapping("/getTravelData")
    @ResponseBody
    public String getdata(HttpServletRequest req, Model model) {
    	int start, psize;
		String page = req.getParameter("pageno");
		String category = req.getParameter("category");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=tdao.cntTravelList(category);
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/travel_list?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
    	ArrayList<travel_attDTO> getlist = tdao.getList(start, psize, category);
        JSONArray ja = new JSONArray();
        
        for (int i = 0; i < getlist.size(); i++) {
            JSONObject jo = new JSONObject();
            jo.put("ta_num", getlist.get(i).getTa_num());
            jo.put("ta_name", getlist.get(i).getTa_name());
            jo.put("ta_local", getlist.get(i).getTa_local());
            jo.put("ta_address", getlist.get(i).getTa_address());
            jo.put("ta_latitude", getlist.get(i).getTa_latitude());
            jo.put("ta_longitude", getlist.get(i).getTa_longitude());
            ja.add(jo);
        }
        return ja.toJSONString();
    }
    @GetMapping("/travel_Detail")
    public String detail(HttpServletRequest req,Model model) {
    	String ta_name=req.getParameter("ta_name");
    	travel_attDTO detail = tdao.getDetail(ta_name);
    	 
    	String ta_imginfo = detail.getTa_imginfo();
    	String ta_content = detail.getTa_content();
    	String[] ta_contentParts = ta_content.split("/");
    	String[] ta_imginfoParts = ta_imginfo.split("/");
    	
    	tdao.hitup(ta_name);
    	model.addAttribute("detail", detail);
        model.addAttribute("ta_imginfoParts", ta_imginfoParts);
        model.addAttribute("ta_contentParts", ta_contentParts);
        
    	return "/travel_attraction/travel_detail";
    }
    @PostMapping("/delete_list")
    @ResponseBody
    public String delete(HttpServletRequest req) {
        String ta_name = req.getParameter("ta_name");
        tdao.deleteList(ta_name);
        String imageDirectory = mainuploadDirectory;
        String  mainImageFileName = req.getParameter("ta_img");
        // 이미지 파일 삭제 메서드 호출
        File mainImageFile = new File(imageDirectory, mainImageFileName);
        if (mainImageFile.exists()) {
            mainImageFile.delete(); // 파일을 삭제합니다.
        }
        rdao.deletelist(ta_name);
        return "삭제되었습니다.";
    }

    // 이미지 파일 삭제 메서드
    @PostMapping("/delete_image")
    @ResponseBody
    public String delete_img(HttpServletRequest req) {
        String ta_name = req.getParameter("ta_name");
        travel_attDTO detail_img = tdao.getDetailImg(ta_name);
        String ta_imginfo = detail_img.getTa_imginfo();
        String[] ta_imginfoParts = ta_imginfo.split("/");

        // 이미지 파일이 저장된 디렉토리 경로
        String imageDirectory = detailuploadDirectory;
        
        for (int i = 0; i < ta_imginfoParts.length; i++) {
            String mainImageFileName = ta_imginfoParts[i];
            File mainImageFile = new File(imageDirectory, mainImageFileName);
            if (mainImageFile.exists()) {
                mainImageFile.delete(); // 파일을 삭제합니다.
            }
        }
        tdao.deleteTravel_attraction(ta_name);
        
        return "삭제되었습니다.";
    }
    @GetMapping("/update")
    public String update(HttpServletRequest req,Model model) {
    	String ta_name = req.getParameter("ta_name");
    	travel_attDTO detail = tdao.getDetail(ta_name);
	 
    	String ta_imginfo = detail.getTa_imginfo();
    	String ta_content = detail.getTa_content();
    	String[] ta_contentParts = ta_content.split("/");
    	String[] ta_imginfoParts = ta_imginfo.split("/");
    	
        model.addAttribute("detail", detail);
        model.addAttribute("ta_imginfoParts", ta_imginfoParts);
        model.addAttribute("ta_contentParts", ta_contentParts);
        return "travel_attraction/update";
    }
    @PostMapping("/doupdate")
    public String updateTravelAttraction(@RequestParam(value = "newdetailimg", required = false) MultipartFile[] newdetailImages,
                                         @RequestParam(value = "newlistimg", required = false) MultipartFile newListImage,
                                         @RequestParam(value = "content", required = false) String[] contents,
                                         @RequestParam("name") String name,
                                         HttpServletRequest req,
                                         Model model) {
        try { 	
        	
            if (newdetailImages == null && contents ==null) {
            	String newdetailImage="";
            	String contetn="";
            	tdao.updateTravelAttraction(name, newdetailImage, contetn);
            	return "redirect:/travel_Detail?ta_name=" + name;
            }

        	String ta_name = req.getParameter("ta_name");
            String local = req.getParameter("local");
            String address = req.getParameter("address");
            String category = req.getParameter("category");
            
        	travel_attDTO detail = tdao.getDetail(ta_name);
        	String ta_imginfo = detail.getTa_imginfo();
        	String[] ta_imginfoParts = ta_imginfo.split("/");
            if (!newListImage.isEmpty()) {
                String listImageName = newListImage.getOriginalFilename();
                UUID listImageId = UUID.randomUUID();
                SimpleDateFormat listSdf = new SimpleDateFormat("yyyyMMddkkmmss");
                Date listDate = new Date();
                String formattedListDate = listSdf.format(listDate);
                String savedListImageName = listImageId.toString() + formattedListDate + "." + StringUtils.getFilenameExtension(listImageName);
                File listImageFile = new File(mainuploadDirectory + File.separator + savedListImageName);
                newListImage.transferTo(listImageFile);
                tdao.updateList1(name,local,savedListImageName,address,category,ta_name);
            } else {
            	tdao.updateList2(name,local,address,category,ta_name);
            }
            tdao.updateDetailInfo(name,ta_name);
            // 이미지 수정을 위한 인덱스
            int imageIndex = 0;
            StringBuilder detailImagePaths = new StringBuilder();

            for (MultipartFile detailImage : newdetailImages) {
                if (!detailImage.isEmpty()) {
                    // 파일 업로드 로직
                    String detailImageName = detailImage.getOriginalFilename();
                    UUID detailImageId = UUID.randomUUID();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
                    Date date = new Date();
                    String formattedDate = sdf.format(date);
                    String savedDetailImageName = detailImageId.toString() + formattedDate + "." + StringUtils.getFilenameExtension(detailImageName);
                    File detailImageFile = new File(detailuploadDirectory + File.separator + savedDetailImageName);
                    detailImage.transferTo(detailImageFile);

                    // 기존 이미지와 새 이미지 교체
                    if (detailImagePaths.length() > 0) {
                        detailImagePaths.append("/");
                    }
                    detailImagePaths.append(savedDetailImageName);
                } else {
                    // 이미지가 비어 있으면 기존 이미지 경로 사용
                    if (imageIndex < ta_imginfoParts.length) {
                        if (detailImagePaths.length() > 0) {
                            detailImagePaths.append("/");
                        }
                        detailImagePaths.append(ta_imginfoParts[imageIndex]);
                    }
                }
                // 이미지 수정을 위한 인덱스 증가
                imageIndex++;
            }

            // 콘텐츠 수정
            StringBuilder taContentBuilder = new StringBuilder();
            for (String detailInfo : contents) {
                if (detailInfo == null || detailInfo.isEmpty()) {
                    taContentBuilder.append("/");
                } else {
                    if (taContentBuilder.length() > 0) {
                        taContentBuilder.append("/");
                    }
                    taContentBuilder.append(detailInfo);
                }
            }

            String taContent = taContentBuilder.toString();

            // 여행지 정보 및 이미지 업데이트
            tdao.updateTravelAttraction(name, detailImagePaths.toString(), taContent);

            return "redirect:/travel_Detail?ta_name=" + name;
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "파일 업로드 실패");
        }

        return "redirect:/travel_Detail?ta_name=" + name;
    }
    @PostMapping("/deleteImage")
    @ResponseBody
    public String deleteImage(@RequestParam("ta_name") String taName,
                              @RequestParam("imageToDelete") String imageToDelete,
                              RedirectAttributes redirectAttributes) {
        try {
            // 1. DB에서 해당 레코드를 가져옵니다.
            travel_attDTO detail = tdao.getDetail(taName);

            // 2. 가져온 문자열을 '/'로 분할하여 배열로 변환합니다.
            String ta_imginfo = detail.getTa_imginfo();
            String[] ta_imginfoParts = ta_imginfo.split("/");

            // 3. 삭제하려는 이미지를 배열에서 제거하고 빈 문자열을 추가합니다.
            List<String> updatedImageList = new ArrayList<>(Arrays.asList(ta_imginfoParts));
            updatedImageList.remove(imageToDelete);
            updatedImageList.add("");

            // 4. 업데이트된 문자열을 '/'로 합쳐서 문자열로 변환합니다.
            String updatedTaImgInfo = String.join("/", updatedImageList);

            // 5. DB에 다시 저장합니다.
            tdao.updateTravelAttraction(taName, updatedTaImgInfo, detail.getTa_content());

            return "success"; // 이미지 삭제 성공 메시지를 리턴
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // 이미지 삭제 실패 메시지를 리턴
        }
    }

    @PostMapping("/updatedetail")
    @ResponseBody
    public String updateDetail(@RequestParam("ta_name") String taName,
                               @RequestParam("content") String content,
                               @RequestParam(value = "newdetailimg", required = false) MultipartFile newDetailImage,
                               RedirectAttributes redirectAttributes) {
        try {
            // 기존 텍스트 컨텐츠를 가져오기 (여기에서는 어떻게 가져올지에 대한 로직을 추가해야 합니다)
            travel_attDTO detail = tdao.getDetail(taName);
            String ta_content = detail.getTa_content();
            String[] ta_contentParts = ta_content.split("/");

            // content가 비어 있거나 null일 경우 빈 문자열("")로 초기화
            if (content == null || content.isEmpty()) {
                content = "";
            }

            // 기존 컨텐츠와 새로운 컨텐츠를 합쳐서 업데이트
            StringBuilder updatedContentBuilder = new StringBuilder();
            for (String part : ta_contentParts) {
                if (!part.isEmpty()) {
                    updatedContentBuilder.append(part).append("/");
                }
            }
            // content가 비어있는 경우 뒤의 "/"가 추가되지 않도록 조건을 추가합니다.
            if (!content.isEmpty()) {
                updatedContentBuilder.append(content);
            }
            String updatedContent = updatedContentBuilder.toString();

            // 이미지 추가 로직
            if (newDetailImage != null && !newDetailImage.isEmpty()) {
                String detailImageName = newDetailImage.getOriginalFilename();
                UUID detailImageId = UUID.randomUUID();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
                Date date = new Date();
                String formattedDate = sdf.format(date);
                String savedDetailImageName = detailImageId.toString() + formattedDate + "." + StringUtils.getFilenameExtension(detailImageName);
                File detailImageFile = new File(detailuploadDirectory + File.separator + savedDetailImageName);
                newDetailImage.transferTo(detailImageFile);

                // DB에 새 이미지 경로 추가
                String ta_imginfo = detail.getTa_imginfo();
                if (ta_imginfo == null || ta_imginfo.isEmpty()) {
                    ta_imginfo = savedDetailImageName;
                } else {
                    ta_imginfo += "/" + savedDetailImageName;
                }
                tdao.updateTravelAttraction(taName, ta_imginfo, updatedContent);
            } else {
                // 이미지가 없을 경우 컨텐츠만 업데이트
                tdao.updateContent(taName, updatedContent);
            }

            return "업데이트 및 이미지 추가 성공: " + content;
        } catch (Exception e) {
            e.printStackTrace();
            return "업데이트 및 이미지 추가 실패: " + e.getMessage();
        }
    }
    @PostMapping("/deleteContent")
    @ResponseBody
    public String deleteContent(@RequestParam("ta_name") String taName,
                                @RequestParam("contentToDelete") String contentToDelete) {
        try {
            travel_attDTO detail = tdao.getDetail(taName);
            
            String ta_content = detail.getTa_content();
            String[] ta_contentParts = ta_content.split("/");
            
            List<String> deleteContent = new ArrayList<>(Arrays.asList(ta_contentParts));
          
            // contentToDelete를 ArrayList에서 정확하게 찾아내고 그 위치를 contentToDeleteIndex에 저장
            int contentToDeleteIndex = deleteContent.indexOf(contentToDelete);
            
            if (contentToDeleteIndex >= 0) {
                // contentToDelete를 찾은 경우에만 삭제와 추가를 수행
                deleteContent.remove(contentToDeleteIndex);
                // 삭제된 컨텐츠의 위치에 빈 문자열을 추가
                deleteContent.add(contentToDeleteIndex, "");
            } else {
                // contentToDelete를 찾지 못한 경우에 대한 예외 처리
                return "컨텐츠 삭제 실패: 해당 컨텐츠를 찾을 수 없습니다.";
            }
            
            // 삭제된 컨텐츠를 "/"로 합쳐서 업데이트
            String updatedTaContent = String.join("/", deleteContent);
            
            // DB 업데이트 시 ta_imginfo는 그대로 사용
            tdao.updateTravelAttraction(taName, detail.getTa_imginfo(), updatedTaContent);

            // 삭제 작업이 성공하면 메시지를 반환합니다.
            return "컨텐츠 삭제 성공: " + contentToDelete;
        } catch (Exception e) {
            e.printStackTrace();
            return "컨텐츠 삭제 실패: " + e.getMessage();
        }
    }
    @PostMapping("/insertReview")
    @ResponseBody
    public String review(HttpServletRequest req) throws JsonProcessingException {
        HttpSession session = req.getSession();
        String id = (String) session.getAttribute("id");
        String reviewContents = req.getParameter("content");
        int rating = Integer.parseInt(req.getParameter("rating"));
        String ta_name = req.getParameter("ta_name");
        tdao.insertReview(ta_name, id, rating, reviewContents);

        return "리뷰 등록이 성공하였습니다.";
    }
    @PostMapping("/deleteReview")
    @ResponseBody
    public String deleteReview(HttpServletRequest req) {
    	int reviewNum=Integer.parseInt(req.getParameter("reviewNum"));
    	rdao.deleteReview(reviewNum);
    	return "성공";
    }
    
    @PostMapping("/getReviewList")
    @ResponseBody
    public String getReviewList(HttpServletRequest req, Model model) {
        String ta_name = req.getParameter("ta_name");
        int start, psize;
        String page = req.getParameter("pageno");
        if (page == null || page.equals("")) {
            page = "1";
        }	
        int pno = Integer.parseInt(page);
        start = (pno - 1) * 5;
        psize = 5;
        int cnt = rdao.cntReviewList(ta_name);
        int pagecount = (int)Math.ceil(cnt / 5.0);
        String pagestr = "";
        for (int i = 1; i <= pagecount; i++) {
            if (pno == i) {
                pagestr += i + "&nbsp;";
            } else {
                pagestr += "<a href='/travel_Detail?ta_name=test2&pageno=" + i + "'>" + i + "</a>&nbsp;";
            }
        }
        model.addAttribute("pagestr", pagestr);
        ArrayList<reviewDTO> review = rdao.getReviewList(ta_name, start, psize);
        JSONArray ja = new JSONArray();
        for (int i = 0; i < review.size(); i++) {
            JSONObject jo = new JSONObject();
            jo.put("review_num", review.get(i).getReview_num());
            jo.put("review_location", review.get(i).getReview_location());
            jo.put("review_id", review.get(i).getReview_id());
            jo.put("review_rating", review.get(i).getReview_rating());
            jo.put("review_content", review.get(i).getReview_content());
            jo.put("review_created", review.get(i).getReview_created());
            ja.add(jo);
        }    
        // JSON 응답 데이터 생성 (페이지 번호와 리뷰 데이터를 포함)
        JSONObject response = new JSONObject();
        response.put("pagestr", pagestr);
        response.put("reviews", ja);
        
        return response.toJSONString();
    }

    @PostMapping("/addCart")
    @ResponseBody
    public String addcart(HttpServletRequest req) {
    	HttpSession session = req.getSession();
        String id = (String) session.getAttribute("id");
    	String ta_name = req.getParameter("ta_name");
    	String ta_category=req.getParameter("ta_category");
    	int ta_num = Integer.parseInt(req.getParameter("ta_num"));
    	System.out.println(ta_name);
    	cdao.addCart(ta_name,ta_category,ta_num,id);
    	
    	int cnt = cdao.totalCart(ta_name);
    	return cnt+"";
    }
    
    @PostMapping("/cntCart")
    @ResponseBody
    public String cntcart(HttpServletRequest req) {
    	HttpSession session = req.getSession();
        String id = (String) session.getAttribute("id");
        String ta_name = req.getParameter("ta_name");
        System.out.println(id);
        int cnt = cdao.cntCart(ta_name,id);
        return cnt+"";
    }
    @PostMapping("/removeCart")
    @ResponseBody
    public String removeCart(HttpServletRequest req) {
    	HttpSession session = req.getSession();
        String id = (String) session.getAttribute("id");
        String ta_name = req.getParameter("ta_name");
        
        cdao.removeCart(ta_name,id);
        int cnt = cdao.totalCart(ta_name);
    	return cnt+"";
    }
    @PostMapping("/addLike")
    @ResponseBody
    public String addlike(HttpServletRequest req) {
    	HttpSession session = req.getSession();
        String id = (String) session.getAttribute("id");
    	String ta_name = req.getParameter("ta_name");
    	String ta_category=req.getParameter("ta_category");
    	int ta_num = Integer.parseInt(req.getParameter("ta_num"));
    	
    	ldao.addLike(ta_category,ta_name,id,ta_num);
    	int cnt = ldao.totalLike(ta_name);
    	return cnt+"";
    }
    @PostMapping("/removeLike")
    @ResponseBody
    public String removeLike(HttpServletRequest req) {
    	HttpSession session = req.getSession();
        String id = (String) session.getAttribute("id");
        String ta_name = req.getParameter("ta_name");
        
        ldao.removeLike(ta_name,id);
        int cnt = ldao.totalLike(ta_name);
    	return cnt+"";
    }
    @PostMapping("/cntLike")
    @ResponseBody
    public String cntLike(HttpServletRequest req) {
    	HttpSession session = req.getSession();
        String id = (String) session.getAttribute("id");
        String ta_name = req.getParameter("ta_name");
        System.out.println(id);
        int cnt = ldao.cntLike(ta_name,id);
        return cnt+"";
    }
    @PostMapping("/totalCart")
    @ResponseBody
    public String totoalcart(HttpServletRequest req) {
    	String ta_name = req.getParameter("ta_name");
    	int cnt = cdao.totalCart(ta_name);
    	return cnt+"";
    }
    @PostMapping("/totalLike")
    @ResponseBody
    public String totoalLike(HttpServletRequest req) {
    	String ta_name = req.getParameter("ta_name");
    	int cnt = ldao.totalLike(ta_name);
    	return cnt+"";
    }
    @PostMapping("/update_content")
    @ResponseBody
    public String update_content(HttpServletRequest req) {
    	int reviewNum = Integer.parseInt(req.getParameter("reviewNum"));
    	String updatedText=req.getParameter("updatedText");
    	int rating = Integer.parseInt(req.getParameter("rating"));
    	System.out.println(updatedText);
    	rdao.updateContent(reviewNum,updatedText,rating);
    	return "성공";
    }
}

