<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*" %>

<%
  String timing = properties.get("timing", null);
  String[] testimonialPaths = properties.get("testimonial-path", String[].class);
  
%>

<c:set var="varTiming" value="<%= timing  %>"/>
<c:set var="varTestimonialPaths" value="<%= testimonialPaths  %>"/>

<c:if test="${fn:length(varTestimonialPaths) > 0}">
<div data-js-loader='["user-review.js"]'></div>
	 <div class="user-review">
	 	<div class="user-reviews-detail">
	 		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	 			<div class="js-user-review-feed swiper-container">
	 				<span class="border-corner top-left" style="background-image: url(<%=imgPath %>/others/dots2.png)"></span>
	 				<span class="border-corner top-right" style="background-image: url(<%=imgPath %>/others/dots2.png)"></span>
	 				<span class="border-corner bottom-left" style="background-image: url(<%=imgPath %>/others/dots2.png)"></span>
	 				<span class="border-corner bottom-right" style="background-image: url(<%=imgPath %>/others/dots2.png)"></span>
	 				
	 				<div class="swiper-wrapper">
	 					
	 					<%
	 					  for (int i = 0; i < testimonialPaths.length ; i++) {
	 							String testimonialPath = testimonialPaths[i];
	 							Page testimonialPage = pageManager.getPage(testimonialPath);
	 							
	 							Node testimonialNode = WCMUtil.getNodePropertyValueByPage(testimonialPage, "customer_testimonial") != null ? WCMUtil.getNodePropertyValueByPage(testimonialPage, "customer_testimonial") : currentNode;
	 							String customerAge = WCMUtil.getNodePropertyValue(testimonialNode, "customer-age");
	 							String customerImgAlt = WCMUtil.getNodePropertyValue(testimonialNode, "customer-img-alt_t");
	 							String customerImgPath = WCMUtil.getNodePropertyValue(testimonialNode, "customer-img-path");
	 							String customerName = WCMUtil.getNodePropertyValue(testimonialNode, "customer-name_t");
	 							String customerReview = WCMUtil.getNodePropertyValue(testimonialNode, "customer-review_t");
	 							String customerSaluation = WCMUtil.getNodePropertyValue(testimonialNode, "customer-saluation_t");
	 					%>
	 					
	 					<c:set var="varCustomerAge" value="<%= customerAge  %>"/>
						<c:set var="varCustomerImgAlt" value="<%= customerImgAlt  %>"/>
						<c:set var="varCustomerImgPath" value="<%= customerImgPath  %>"/>
						<c:set var="varCustomerName" value="<%= customerName  %>"/>
						<c:set var="varCustomerReview" value="<%= customerReview  %>"/>
						<c:set var="varCustomerSaluation" value="<%= customerSaluation  %>"/>
						
 						<!-- Start Loop -->
 						<div class="user-review-feed-item swiper-slide">
 							<div class="thumbnail">
 								<span class="border-corner top-left" style="background-image: url(<%=imgPath %>/others/dots2.png)"></span>
 								<span class="border-corner top-right" style="background-image: url(<%=imgPath %>/others/dots1.png)"></span>
 								<span class="border-corner bottom-left" style="background-image: url(<%=imgPath %>/others/dots1.png)"></span>
 								<span class="border-corner bottom-right" style="background-image: url(<%=imgPath %>/others/dots2.png)"></span> 
 								
 								<img src="${varCustomerImgPath}" alt="${varCustomerImgAlt}" data-rjs="2">
								<div class="caption">${varCustomerName}, ${varCustomerAge}</div>
								<p>${varCustomerSaluation}</p>
							</div>
 							
 							<p class="comment">${varCustomerReview}</p>
 						</div>
 						<% } %>
 						<!--  End loop -->
					</div>
	 				
	 				<!-- pagination -->
	 				<div class="swiper-pagination"></div>
	 				
	 				<!--  start arrows -->
					<div class="swiper-next">
						<div class="swiper-button-wrapper">
							<div class="swiper-button">
								<svg class="brands-icon link-icon-small icon-center">
                           <use
										href="<%=svgIconPath%>#icon-arrow-right"
										xlink:href="<%=svgIconPath%>#icon-arrow-right"></use>
                         </svg>
							</div>
						</div>
					</div>
					<div class="swiper-prev">
						<div class="swiper-button-wrapper">
							<div class="swiper-button">
								<svg class="brands-icon link-icon-small icon-center">
                            <use
										href="<%=svgIconPath%>#icon-arrow-left"
										xlink:href="<%=svgIconPath%>#icon-arrow-left"></use>
                          </svg>
							</div>
						</div>
					</div>
					<!--  end arrows -->
					
				</div>
	 		</div>
	 	</div>
	 </div>

</c:if>
