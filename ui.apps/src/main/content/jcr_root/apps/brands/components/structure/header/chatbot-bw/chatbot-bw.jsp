<%@include file="/apps/brands/global/global.jsp" %><%
%><%
String initialMessage = pageProperties.get("init-chatbot-msg_t", "Hello!");
String subsequentMessage = pageProperties.get("sub-chatbot-msg_t", "Welcome back!");
%>

<c:set var="varChatbotInitialMsg" value="<%= initialMessage %>"/>
<c:set var="varChatbotSubMsg" value="<%= subsequentMessage %>"/>

<!-- chatbot global starts here-->
<div class="chatbot-global" id="chatbot-global" style="display:none;">
  <button class="btn btn-default secondary-color pull-right" id="closeglobalchatbot">
    <svg class="brands-icon icon-white">
      <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-close" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-close"></use>
    </svg>
  </button>
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
    
  <!-- chatbot-welcome molecule end here-->
  <!-- chatbot-help molecule start here-->
 
  <!-- chatbot-help molecule end here-->
  
  <!-- chatbot-wrapper component end here-->
  <div class="chatbot-messagebox">
    <div class="input-group input-group-lg">
      <input class="form-control" id="globalchatbotmsg" placeholder="Type your question here" type="text">
      <span class="input-group-addon">
			<svg class="brands-icon" id="btnsendglobal">
			<use href="<%=svgIconPath%>#icon-send" xlink:href="<%=svgIconPath%>#icon-send"></use>
			</svg>
		</span>
    </div>
  </div>
</div>
<!-- chatbot global ends here-->