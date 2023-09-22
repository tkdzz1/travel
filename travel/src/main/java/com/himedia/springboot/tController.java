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
    @PostMapping("/doupdate")
    public String updateTravelAttraction(@RequestParam("newdetailimg") MultipartFile[] newdetailImages,
							    		 @RequestParam("newlistimg") MultipartFile newListImage,
							    		 @RequestParam("content") String[] contents,
                                         @RequestParam("name") String name,
                                         HttpServletRequest req,
                                         Model model) {
        try { 	
        	String ta_name = req.getParameter("ta_name");
            String local = req.getParameter("local");
            String address = req.getParameter("address");
            String category = req.getParameter("category");
            
        	travel_attDTO detail = tdao.getdetail(ta_name);
        	
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
                tdao.updatelist1(name,local,savedListImageName,address,category,ta_name);
            } else {
            	tdao.updatelist2(name,local,address,category,ta_name);
            }
            tdao.updatedetailinfo(name,ta_name);
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

            return "redirect:/travel_detail?ta_name=" + name;
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "파일 업로드 실패");
        }

        return "redirect:/travel_detail?ta_name=" + name;
    }
    @PostMapping("/deleteImage")
    @ResponseBody
    public String deleteImage(@RequestParam("ta_name") String taName,
                              @RequestParam("imageToDelete") String imageToDelete,
                              RedirectAttributes redirectAttributes) {
        try {
            // 1. DB에서 해당 레코드를 가져옵니다.
            travel_attDTO detail = tdao.getdetail(taName);

            // 2. 가져온 문자열을 '/'로 분할하여 배열로 변환합니다.
            String ta_imginfo = detail.getTa_imginfo();
            String[] ta_imginfoParts = ta_imginfo.split("/");

            // 3. 삭제하려는 이미지를 배열에서 제거합니다.
            List<String> updatedImageList = new ArrayList<>(Arrays.asList(ta_imginfoParts));
            updatedImageList.remove(imageToDelete);

            // 4. 업데이트된 문자열을 DB에 다시 저장합니다.
            String updatedTaImgInfo = String.join("/", updatedImageList);
            tdao.updateTravelAttraction(taName, updatedTaImgInfo, detail.getTa_content());

            return "success"; // 이미지 삭제 성공 메시지를 리턴
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // 이미지 삭제 실패 메시지를 리턴
        }
    }

    @PostMapping("/addImage")
    @ResponseBody
    public String addImage(@RequestParam("ta_name") String taName,
                           @RequestParam("newdetailimg") MultipartFile newDetailImage,
                           RedirectAttributes redirectAttributes) {
        try {
            if (!newDetailImage.isEmpty()) {
                // 파일 업로드 로직
            	String detailImageName = newDetailImage.getOriginalFilename();
            	UUID detailImageId = UUID.randomUUID();
            	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
            	Date date = new Date();
            	String formattedDate = sdf.format(date);
            	String savedDetailImageName = detailImageId.toString() + formattedDate + "." + StringUtils.getFilenameExtension(detailImageName);
            	File detailImageFile = new File(detailuploadDirectory + File.separator + savedDetailImageName); // detailuploadDirectory 변수 사용
            	newDetailImage.transferTo(detailImageFile);

                // DB에 새 이미지 경로 추가
                travel_attDTO detail = tdao.getdetail(taName);
                String ta_imginfo = detail.getTa_imginfo();
                if (ta_imginfo == null || ta_imginfo.isEmpty()) {
                    ta_imginfo = savedDetailImageName;
                } else {
                    ta_imginfo += "/" + savedDetailImageName;
                }
                tdao.updateTravelAttraction(taName, ta_imginfo, detail.getTa_content());

                return "success"; // 이미지 추가 성공 메시지를 리턴
            } else {
                return "error"; // 이미지가 비어 있을 경우 에러 메시지를 리턴
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // 이미지 추가 중 오류가 발생했을 경우 에러 메시지를 리턴
        }
    }

}