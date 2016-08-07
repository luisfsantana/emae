<%@ attribute name="id" required="true" %>
<%@ attribute name="name" required="true" %> 
<%@ attribute name="value" required="false" %> 


<input id="${id}" name="${name}" type="text" value="${value}"/>

  <script>
  $(function() {
    $( "#${id}" ).datepicker({
    	changeMonth: true,	
        changeYear: true,
        maxDate: '0',
        navigationAsDateFormat: true,
        nextText: "Later",
        yearRange: "1950:2005"
     });
     $( "#${id}" ).datepicker( "option", "showAnim", "drop" );
     $( "#${id}" ).datepicker( "option", "dateFormat", "dd/mm/yy");
     $( "#${id}" ).datepicker( "option", "dayNamesMin", ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"]);
     $( "#${id}" ).datepicker( "option", "monthNamesShort", ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul","Agos", "Set", "Out", "Nov", "Dez"]);

  });
  

  </script>