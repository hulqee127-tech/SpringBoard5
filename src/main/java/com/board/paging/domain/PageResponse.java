package com.board.paging.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageResponse<T> {
	//현재 페이지에 보여줄 DB 자료 : select 의 결과
	private List<T> list = new ArrayList<>();
	
	private Pagination pagination;

	public PageResponse(List<T> list, Pagination pagination) {
		this.list = list;
		this.pagination = pagination;
	}
	
}
