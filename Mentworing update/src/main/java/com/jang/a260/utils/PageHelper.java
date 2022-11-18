package com.jang.a260.utils;

import org.springframework.stereotype.Component;

import com.jang.a260.model.SearchVO;



@Component
public class PageHelper {

	private int pageSize = 5; // 한 페이지당 보이는 게시물 수
	private int blockSize = 5; //한 블럭당 보이는 페이지 수
	public int getPageSize() {
	return pageSize;
	}
	public int getBlockSize() {
	return blockSize;
	}
	// 현재 페이지와 전체 레코드수를 입력 받아 페이징 표시 문자열을 반환한다.
	public StringBuffer getPageUrl(SearchVO searchVO, int totalRow) {
		
		StringBuffer pageHtml = new StringBuffer();
		
		int currentPage=searchVO.getPage();
		String key=searchVO.getKeyword();
		String type=searchVO.getType();
		
		String smsg=null;
		if (key != "") {
			smsg="&type="+type+"&keyword="+key;
		}
		else{
			smsg="";
		}
		int startPage = 0;
		int endPage = 0;
		//표시할 시작페이지와 끝페이지 계산
		startPage = ((currentPage-1) / blockSize) * blockSize + 1;
		endPage = startPage + blockSize - 1;
		//전체 페이지 수와 블럭수 계산
		int totalPage = totalRow/pageSize + 1;
		int totalBlock = totalPage/blockSize + 1;
		int currentBlock = currentPage/blockSize + 1; 
		
		//표시되는 현재 블럭의 끝 페이지가 전체 마지막 페이지인 경우- 전체 페이지보다 큰 경우 발생시 조정 : 223행/10 + 1 = 23페이지
		if( endPage > (totalRow / pageSize ) ) {
		endPage = (totalRow /pageSize) + 1;
		}
		//현재 블럭이 2 이상인 경우 [이전] 표시
		if(currentBlock > 1){
		pageHtml.append("<span><a href=\"userlist?page=" + (currentPage-1) + smsg+ "\"><이전></a>&nbsp;&nbsp;");
		}else{
		pageHtml.append("<span>");
		}
		//현재 블럭안에 포함될 페이지 표시
		for(int i = startPage ; i <= endPage ; i++) {
		if(i == currentPage){
		pageHtml.append(".&nbsp;<strong>");
		pageHtml.append( i );
		pageHtml.append("&nbsp;</strong>");
		} else {
		pageHtml.append(".&nbsp;<a href=\"userlist?page=" +i+smsg+ "\" class=\"page\">" + i + "</a>&nbsp;");
		}
		}
		//현재 블록 안이 전체 블럭 보다 작으면 [다음] 표시
		if(currentBlock < totalBlock){
		pageHtml.append(".&nbsp;&nbsp;<a href=\"userlist?page=" + (currentPage+1) +smsg+ "\"><다음></a></span>");
		}else{
		pageHtml.append(".</span>");
		}
		return pageHtml; 
	}
}
