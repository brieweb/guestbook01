<%@ include file="init.jsp" %>

<portlet:actionURL name="addEntry" var="addEntryURL"></portlet:actionURL>

<portlet:renderURL var="viewURL">
    <portlet:param name="mvcPath" value="/view.jsp"></portlet:param>
</portlet:renderURL>

<aui:form action="<%= addEntryURL %>" name="<portlet:namespace />fm">
        <aui:fieldset>
            <aui:input name="name"></aui:input>
            <aui:input name="message"></aui:input>
        </aui:fieldset>
        
        <aui:button name="chooseImage" value="Choose" />

<%
String itemSelectorURL = GetterUtil.getString(request.getAttribute("itemSelectorURL"));
%>

<aui:script use="liferay-item-selector-dialog">

    $('#<portlet:namespace />chooseImage').on(
        'click', 
        function(event) {
            var itemSelectorDialog = new A.LiferayItemSelectorDialog(  
                {
                    eventName: 'ItemSelectedEventName',
                    on: {
                            selectedItemChange: function(event) {
                                var selectedItem = event.newVal;

                                if (selectedItem) {
                                    var itemValue = JSON.parse(
                                    selectedItem.value
                                    );
                                    itemSrc = itemValue.url;

                                    <!-- use item as needed -->
                                }
                            }
                    },
                    title: '<liferay-ui:message key="select-image" />',
                    url: '<%= itemSelectorURL.toString() %>'
                }
            );
            itemSelectorDialog.open();
        }
    );
</aui:script>

        <aui:button-row>
            <aui:button type="submit"></aui:button>
            <aui:button type="cancel" onClick="<%= viewURL.toString() %>"></aui:button>
        </aui:button-row>
</aui:form>