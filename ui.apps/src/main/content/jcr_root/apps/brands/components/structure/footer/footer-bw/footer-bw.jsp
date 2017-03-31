<%@include file="/apps/brands/global/global.jsp"%>

<%
//0 means default, no change
//1 means country specific
String footerType = pageProperties.getInherited("footerType", "0");
%>
<!-- footer component start here-->
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="footer-container">
				
				<%
				if(footerType.equalsIgnoreCase("0")){
					%>
					<cq:include path="back-to-top-bw" resourceType="brands/components/structure/footer/back-to-top-bw" />
					<cq:include script="footer-mobile.jsp" />
					<cq:include script="footer-desktop.jsp" />
					<div class="row extra-footer">
						<cq:include path="bottom-bar-bw" resourceType="brands/components/structure/footer/bottom-bar-bw" />
					</div>
				<%
				} else {
					%><cq:include script="footer-cntryspecific.jsp" /><%
				}
				%>

			</div>
		</div>
	</div>
</div>
<!-- footer component end here-->