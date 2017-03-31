<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils" %><%
%><%

String prdtSelectedLbl = properties.get("prdt-selected-label_t", "products selected");
String prdtClearAllLbl = properties.get("prdt-clear-all-label_t", "clear all selection");
String prdtCtaTxt = properties.get("prdt-compare-cta-text_t", "compare");
String prdtComparePath = properties.get("prdt-compare-path", "");
if(StringUtils.isNotEmpty(prdtComparePath)) {
    prdtComparePath =  WCMUtil.getURL(prdtComparePath, isAuthor);
}
String prdtMaxItems = properties.get("prdt-compare-max", "4");

%>

<!-- product comparison bar start here-->
<div class="section-container product-comparison-bar-container hide" data-max-col="<%=prdtMaxItems%>">
    <div class="background-container primary-background-color-full">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-8 col-md-8 hidden-sm hidden-xs">
                    <div class="row"></div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="product-comparison-item-detail">
                        <div class="row">

                          <div class="col-sm-6 col-xs-6">
                            <p class="select-indicator">1 out of <%=prdtMaxItems%></p>

                            <p><%=prdtSelectedLbl%></p>

                            <a class="btn btn-link" id="clearallselection">
                                <%=prdtClearAllLbl%>
                            </a>
                          </div>

                          <div class="col-sm-6 col-xs-6">
                              <a id="comparenow" class="btn btn-action" data-href="<%=prdtComparePath%>">
                                  <%=prdtCtaTxt%>
                              </a>
                          </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- product comparison bar end here-->