package com.himedia.springboot;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class tController {
	@Autowired
	private travel_attDAO tdao;
		
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
		int cnt=tdao.cntlist();
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
		ArrayList<travel_attDTO> getlist = tdao.getList(start,psize);
		model.addAttribute("list", getlist);	
		return "travel_attraction/travel_list";
	}
	
	@GetMapping("/add_list")
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
	                    	System.out.println("공백");
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
                tdao.addlist(name, local, savedMainName, address, category, latitude, longitude);
                tdao.addimginfo(name,detailImagePaths.toString(),taContent);
                model.addAttribute("fileName", mainFile);
                return "redirect:/travel_list";
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
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=tdao.cntlist();
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
    	ArrayList<travel_attDTO> getlist = tdao.getList(start, psize);
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
    @GetMapping("/travel_detail")
    public String detail(HttpServletRequest req,Model model) {
    	String ta_name=req.getParameter("ta_name");
    	travel_attDTO detail = tdao.getdetail(ta_name);
    	 
    	String ta_imginfo = detail.getTa_imginfo();
    	String ta_content = detail.getTa_content();
    	String[] ta_contentParts = ta_content.split("/");
    	String[] ta_imginfoParts = ta_imginfo.split("/");
    	
        model.addAttribute("detail", detail);
        model.addAttribute("ta_imginfoParts", ta_imginfoParts);
        model.addAttribute("ta_contentParts", ta_contentParts);
        System.out.println("ta_imginfoParts 배열 내용:");
        for (String item : ta_imginfoParts) {
            System.out.println(item);
        }
    	    
    	return "/travel_attraction/travel_detail";
    }
    @PostMapping("/delete_list")
    @ResponseBody
    public String delete(HttpServletRequest req) {
        String ta_name = req.getParameter("ta_name");
        tdao.deletelist(ta_name);
        String imageDirectory = mainuploadDirectory;
        String  mainImageFileName = req.getParameter("ta_img");
        // 이미지 파일 삭제 메서드 호출
        File mainImageFile = new File(imageDirectory, mainImageFileName);
        if (mainImageFile.exists()) {
            mainImageFile.delete(); // 파일을 삭제합니다.
        }
        
        return "삭제되었습니다.";
    }

    // 이미지 파일 삭제 메서드
    @PostMapping("/delete_image")
    @ResponseBody
    public String delete_img(HttpServletRequest req) {
        String ta_name = req.getParameter("ta_name");
        travel_attDTO detail_img = tdao.getdetailimg(ta_name);
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
        tdao.deletedetail(ta_name);
        
        return "삭제되었습니다.";
    }
    @GetMapping("/update")
    public String update(HttpServletRequest req,Model model) {
    	String ta_name = req.getParameter("ta_name");
    	travel_attDTO detail = tdao.getdetail(ta_name);
	 
    	String ta_imginfo = detail.getTa_imginfo();
    	String ta_content = detail.getTa_content();
    	String[] ta_contentParts = ta_content.split("/");
    	String[] ta_imginfoParts = ta_imginfo.split("/");
    	
        model.addAttribute("detail", detail);
        model.addAttribute("ta_imginfoParts", ta_imginfoParts);
        model.addAttribute("ta_contentParts", ta_contentParts);
        return "travel_attraction/update";
    }	
}
