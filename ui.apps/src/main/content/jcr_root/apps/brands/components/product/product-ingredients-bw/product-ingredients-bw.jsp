<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils" %><%
%><%

List<Node> ingredientConfigNodeList	= WCMUtil.getMultiCompositePropertyNodeList(currentPage, "ingredient-text-config");
List<String> ingredientStrList = new ArrayList<String>();

for (Node configNode : ingredientConfigNodeList) {
    String ingrdtConfigPath = WCMUtil.getNodePropertyValue(configNode, "ingredient-page-path");
    String ingrdtConfigText = WCMUtil.getNodePropertyValue(configNode, "ingredient-text_t");
    String ingrdtConfigVol = WCMUtil.getNodePropertyValue(configNode, "ingredient-volume_t");
    String ingredientDisp = "";

    if (StringUtils.isNotEmpty(ingrdtConfigPath)) {
        Page ingredientPage = pageManager.getPage(ingrdtConfigPath);
        ingredientDisp = ingredientPage.getPageTitle();
    } else if (StringUtils.isNotEmpty(ingrdtConfigText)) {
        ingredientDisp = ingrdtConfigText;
    }

    if (StringUtils.isNotEmpty(ingrdtConfigVol)) {
        ingredientDisp = ingredientDisp + " " + ingrdtConfigVol;
    }

    if (StringUtils.isNotEmpty(ingredientDisp)) {
        ingredientStrList.add(ingredientDisp);
    }
}

Map<String, String> nutritionalInfoMap = WCMUtil.getTagMapList(currentPage, site_locale, "nutritional-info");
Boolean hasIngredientInfo = (ingredientStrList != null && ingredientStrList.size() > 0) ? true : false;
Boolean hasNutriInfo = (nutritionalInfoMap != null && nutritionalInfoMap.size() > 0) ? true : false;

List<String> nutritionalList_1 = new ArrayList<String>();
List<String> nutritionalList_2 = new ArrayList<String>();

int i = 0;
for (Map.Entry<String, String> entry : nutritionalInfoMap.entrySet() ) {
    String nutritionalKey = "";
    String nutritionalValue = "";

    nutritionalKey = entry.getKey();
    String[] nutritionalKeys = nutritionalKey.split("/");
    nutritionalKey = nutritionalKeys[nutritionalKeys.length-1];
    nutritionalValue = entry.getValue();

    if ((i % 2) == 0) {
        nutritionalList_1.add(nutritionalValue);
    } else {
        nutritionalList_2.add(nutritionalValue);
    }

    i++;
}

String ingredientColStyle = "col-lg-4 col-md-4 col-sm-4 col-xs-12";
String nutriInfoColStyle = "col-lg-8 col-md-8 col-sm-8 col-xs-12 border-left";
String nutriInfoEvenColStr = "col-lg-5 col-lg-offset-1 col-md-5 col-md-offset-1 col-sm-5 col-sm-offset-1 col-xs-12 col-xs-offset-0";
String nutriInfoOddColStr = "col-lg-5 col-md-5 col-sm-5 col-xs-12";

if(hasIngredientInfo && (!hasNutriInfo)) {
    ingredientColStyle = "col-lg-12 col-md-12 col-sm-12 col-xs-12";
}

if(hasNutriInfo && (!hasIngredientInfo)) {
    nutriInfoColStyle = "col-lg-12 col-md-12 col-sm-12 col-xs-12";
    nutriInfoEvenColStr = "col-lg-4 col-lg-offset-2 col-md-4 col-md-offset-2 col-sm-offset-2 col-sm-4 col-xs-12 col-xs-offset-0";
    nutriInfoOddColStr = "col-lg-4 col-md-4 col-sm-4 col-xs-12";
}

if (nutritionalList_1.size() == 1) {
    nutriInfoEvenColStr = "col-lg-12 col-md-12 col-sm-12 col-xs-12";
}

%>

<c:set var="varNutritionalList_1" value="<%= nutritionalList_1 %>"/>
<c:set var="varNutritionalList_2" value="<%= nutritionalList_2 %>"/>
<c:set var="varIngredientColStyle" value="<%= ingredientColStyle %>"/>
<c:set var="varNutriInfoColStyle" value="<%= nutriInfoColStyle %>"/>
<c:set var="varNutriInfoEvenColStyle" value="<%= nutriInfoEvenColStr %>"/>
<c:set var="varNutriInfoOddColStyle" value="<%= nutriInfoOddColStr %>"/>

<!-- product-ingredients start here-->
	<div class="product-nutrition">
		<div class="container-fluid">
			<div class="row product-nutrition-detail">

			<%
				if (hasIngredientInfo) {
			%>
				<!-- ingredients column start here -->
				<div class="${varIngredientColStyle} primary-border-xs">
					<h4 class="text-center">Ingredients</h4>

					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<ul class="ingredients">

                            <%
                                for (String ingrStr : ingredientStrList) {
                            %>
								<c:set var="varIngredientDisplayTxt" value="<%= ingrStr %>"/>
								<li>${varIngredientDisplayTxt}</li>
                            <%
                                }
							%>

							</ul>
						</div>
					</div>

				</div>
				<!-- ingredients column end here -->
			<%
				}
			%>

			<%
				if (hasNutriInfo) {
			%>
				<!-- nutritional information column start here -->
				<div class="${varNutriInfoColStyle} primary-border-xs">
					<h4 class="text-center">Nutritional Information</h4>
					<div class="row">

						<c:if test="${fn:length(varNutritionalList_1) > 0}">
						<div class="${varNutriInfoEvenColStyle}">
							<ul class="nutrition">

                            <%
								for (String val1 : nutritionalList_1) {
                            %>
								<c:set var="varVal1" value="<%= val1 %>"/>
								<li>${varVal1}</li>
                            <%
								}
                            %>

							</ul>
						</div>
						</c:if>

						<c:if test="${fn:length(varNutritionalList_2) > 0}">
						<div class="${varNutriInfoOddColStyle}">
							<ul class="nutrition">
                            <%
								for (String val2 : nutritionalList_2) {
                            %>
								<c:set var="varVal2" value="<%= val2 %>"/>
								<li>${varVal2}</li>
                            <%
								}
                            %>

							</ul>
						</div>
						</c:if>

					</div>
				</div>
				<!-- nutritional information column end here -->
			<%
				}
			%>

			</div>
		</div>
	</div>
<!-- product-ingredients end here-->