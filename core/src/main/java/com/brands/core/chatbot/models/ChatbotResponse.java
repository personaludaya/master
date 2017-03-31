package com.brands.core.chatbot.models;

import java.util.List;

public class ChatbotResponse {
	private int totalResult;
	private List<Object> results;
	private String viewMoreUrl;
	private String message; //for error purposes
	
	public int getTotalResult() {
		return totalResult;
	}
	public void setTotalResult(int totalResults) {
		this.totalResult = totalResults;
	}
	public List<Object> getResults() {
		return results;
	}
	public void setResults(List<Object> results) {
		this.results = results;
	}
	public String getViewMoreUrl() {
		return viewMoreUrl;
	}
	public void setViewMoreUrl(String viewMoreUrl) {
		this.viewMoreUrl = viewMoreUrl;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
