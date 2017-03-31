<%@include file="/apps/brands/global/global.jsp" %>
<%@ page import="com.day.cq.wcm.api.components.IncludeOptions" %>
<%

String initialMessage = pageProperties.get("init-chatbot-msg_t", "Hello!");
String subsequentMessage = pageProperties.get("sub-chatbot-msg_t", "Welcome back!");

String chatBotBkgrdImg = pageProperties.get("chatbot-bkgrd-img-path", imgPath + "/template/home-screen1-bg.jpg");
String chatBotBkgrdStyle = pageProperties.get("chatbot-bkgrd-style", "background-cover-image");
String beMagBkgrdImg = pageProperties.get("bemag-bkgrd-img-path", imgPath + "/template/home-screen4-bg.jpg");
String beMagBkgrdStyle = pageProperties.get("bemag-bkgrd-style", "background-cover-image");
String instaWallBkgrdImg = pageProperties.get("instagramwall-bkgrd-img-path", imgPath + "/template/home-screen5-bg.jpg");
String instaWallBkgrdStyle = pageProperties.get("instagramwall-bkgrd-style", "background-cover-image");
%>
<c:set var="varChatbotInitialMsg" value="<%= initialMessage %>"/>
<c:set var="varChatbotSubMsg" value="<%= subsequentMessage %>"/>
<c:set var="varChatbotBkgrdImg" value="<%= chatBotBkgrdImg %>" />
<c:set var="varChatbotBkgrdStyle" value="<%= chatBotBkgrdStyle %>" />
<c:set var="varBeMagBkgrdImg" value="<%= beMagBkgrdImg %>" />
<c:set var="varBeMagBkgrdStyle" value="<%= beMagBkgrdStyle %>" />
<c:set var="varInstaWallBkgrdImg" value="<%= instaWallBkgrdImg %>" />
<c:set var="varInstaWallBkgrdStyle" value="<%= instaWallBkgrdStyle %>" />

<div class="swiper-container home-screen">
	<div class="swiper-wrapper" data-name="homepage">

		<div class="swiper-slide home-screens-slide" data-title="chatbot-canvas">
			<div class="section-container home--screen1">

				<div class="background-container ${varChatbotBkgrdStyle}" style="background-image: url(${varChatbotBkgrdImg})" data-swiper-parallax="-100%" data-rjs="2">

					<div class="container-fluid" data-swiper-parallax="-500%">
						<div class="chatbot-component">
							<div class="row">
								<div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3 col-xs-12">
									<!-- chatbot-welcome molecule start here-->
									<!-- <div class="chatbot-welcome">
										<c:choose>
											<c:when test="${not empty cookie.hp_visit_count.value && cookie.hp_visit_count.value != '1'}">
												<h1 class="h1-small">${ varChatbotSubMsg}</h1>
											</c:when>
											<c:otherwise>
												<h1>${varChatbotInitialMsg }</h1>
											</c:otherwise>
										</c:choose>
										<h4>how can I help you?</h4>
									</div>-->
									<!-- chatbot-welcome molecule end here-->									

									<!-- chatbot-wrapper component start here-->
									<div class="chatbot-wrapper">
										<div class="overlay"></div>
										<div class="results">
					                    	<div class="from-chatbot">
					                        	<c:choose>
													<c:when test="${not empty cookie.hp_visit_count.value && cookie.hp_visit_count.value != '1'}">
														<h1 class="message">${ varChatbotSubMsg}</h1>
													</c:when>
													<c:otherwise>
														<h1 class="message">${varChatbotInitialMsg }</h1>
													</c:otherwise>
												</c:choose>
					                      	</div>
					                      	<div class="from-chatbot">
					                        	<h4 class="message">How can I help you?</h4>
					                      	</div>
					                      	<!-- chatbot-help molecule start here-->
					                      	<div class="from-chatbot">
					                        	<h4 class="message"><span>Type in a&nbsp;</span><a>product</a>,&nbsp;<a>an ingredient</a>&nbsp;or a&nbsp;<a>lifestyle-related question</a></h4>
					                      	</div>											
											<!-- chatbot-help molecule end here-->
											<div class="from-chatbot">
					                        	<h4 class="message">For example, Essence of Chicken, berries or how to detox</h4>
					                      	</div>
					                    </div>

										<div class="loader"></div>
									</div>
									<!-- chatbot-wrapper component end here-->
									
									
									<!-- chatbot-messagebox molecule start here-->
									<div class="chatbot-messagebox">
										<div class="input-group input-group-lg">
											<input class="form-control" id="chatbotmsg" placeholder="Type your question here" type="text">
											<span class="input-group-addon">
											<svg class="brands-icon" id="btnsend">
												<use href="<%=svgIconPath%>#icon-send" xlink:href="<%=svgIconPath%>#icon-send"></use>
											</svg></span>
										</div>
									</div>
									<!-- chatbot-messagebox molecule end here-->
								</div>
							</div>
						</div>
					</div>

					<div class="view-all-fixed-bottom">
						<div class="view-all-wrapper text-center">
							<a class="view-all">
								<svg class="brands-icon icon-white icon-mouse">
									<use href="<%=svgIconPath%>#icon-mouse-white" xlink:href="<%=svgIconPath%>#icon-mouse-white"></use>
								</svg>
							</a>
							<div class="scroll-down">
								Scroll down if you do not wish to chat
							</div>
							<a class="view-all">
								<svg class="brands-icon icon-white link-icon-small no-text">
									<use href="<%=svgIconPath%>#icon-arrow-down" xlink:href="<%=svgIconPath%>#icon-arrow-down"></use>
								</svg>
							</a>
						</div>
					</div>

				</div>

			</div>
		</div>

		<div class="swiper-slide home-screens-slide" data-title="popular-products-canvas">
			<div class="section-container home--screen2">
				<div class="popular-products-component">
				<%
					//To remove extra div created by the AEM parsys
					IncludeOptions productCanvasBwOpts = IncludeOptions.getOptions(request, true);
					productCanvasBwOpts.setDecorationTagName("");
				%>
					<cq:include path="product-canvas-bw" resourceType="brands/components/homepage/product-canvas-bw"/>
				</div>
			</div>
		</div>

        <div class="swiper-slide home-screens-slide" data-title="campaign-canvas">
            <div class="section-container home--screen3">
                <div class="campaign-component">
                <%
                    //To remove extra div created by the AEM parsys
                    IncludeOptions campaignCarouselCanvasBwOpts = IncludeOptions.getOptions(request, true);
                    campaignCarouselCanvasBwOpts.setDecorationTagName("");
                %>
                    <cq:include path="campaign-carousel-canvas-bw" resourceType="brands/components/homepage/campaign-carousel-canvas-bw"/>
                </div>
            </div>
        </div>

        <div class="swiper-slide home-screens-slide" data-title="bemagazine-canvas">
            <div class="section-container home--screen4" data-swiper-parallax="-100%">
                <div class="background-container ${varBeMagBkgrdStyle}" style="background-image: url(${varBeMagBkgrdImg});" data-rjs="2" data-rjs-processed="true">
				<%
					//To remove extra div created by the AEM parsys
					IncludeOptions beMagazineCanvasBwOpts = IncludeOptions.getOptions(request, true);
                	beMagazineCanvasBwOpts.setDecorationTagName("");
				%>
                    <cq:include path="be-magazine-canvas-bw" resourceType="brands/components/homepage/be-magazine-canvas-bw"/>

                    <div class="view-all-fixed-bottom">
						<div class="view-all-wrapper text-center">
							<a class="view-all">
								<svg class="brands-icon icon-white link-icon-small no-text">
									<use href="<%=svgIconPath%>#icon-arrow-down" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=svgIconPath%>#icon-arrow-down"></use>
								</svg>
							</a>
						</div>
                    </div>

                </div>
            </div>
        </div>

		<div class="swiper-slide home-screens-slide" data-title="instagram-wall-canvas">
			<div class="section-container home--screen5" data-swiper-parallax="-100%">
				<div class="background-container ${varInstaWallBkgrdStyle}" style="background-image: url( ${varInstaWallBkgrdImg})" data-rjs="2">
				<%
					//To remove extra div created by the AEM parsys
					IncludeOptions headerTitleBwOpts = IncludeOptions.getOptions(request, true);
					headerTitleBwOpts.setDecorationTagName("");
				%>
					<cq:include path="header-title-bw" resourceType="brands/components/content/header-title-bw" />

				<%
					//To remove extra div created by the AEM parsys
					IncludeOptions InstagramWallCanvasBwOpts = IncludeOptions.getOptions(request, true);
					InstagramWallCanvasBwOpts.setDecorationTagName("");
				%>
					<cq:include path="instagram-wall-canvas-bw" resourceType="brands/components/content/instagram-wall-bw"/>
					<cq:include script="footer.jsp" />
				</div>
			</div>
		</div>

	</div>
</div>