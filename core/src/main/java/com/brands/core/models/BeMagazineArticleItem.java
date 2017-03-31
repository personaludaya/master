package com.brands.core.models;

public class BeMagazineArticleItem {
    private String pageTitle;
    private String pageOverview;
    private String pageImgPath;
    private String pageImgAltTxt;
    private String pageUrl;
    private String category;

    public String getPageTitle() {
        return pageTitle;
    }
    public void setPageTitle(String pageTitle) {
        this.pageTitle = pageTitle;
    }
    public String getPageOverview() {
        return pageOverview;
    }
    public void setPageOverview(String pageOverview) {
        this.pageOverview = pageOverview;
    }
    public String getPageImgPath() {
        return pageImgPath;
    }
    public void setPageImgPath(String pageImgPath) {
        this.pageImgPath = pageImgPath;
    }
    public String getPageImgAltTxt() {
        return pageImgAltTxt;
    }
    public void setPageImgAltTxt(String pageImgAltTxt) {
        this.pageImgAltTxt = pageImgAltTxt;
    }
    public String getPageUrl() {
        return pageUrl;
    }
    public void setPageUrl(String pageUrl) {
        this.pageUrl = pageUrl;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
}