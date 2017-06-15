<head>
<meta http-equiv="cache-control" content="max-age=0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="-1">
<meta http-equiv="expires" content="Tue, 01 Jan 1980 11:00:00 GMT">
<meta http-equiv="pragma" content="no-cache">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<base href="{{ base }} " />

{% for link in links %} 
<link href="{{ link.href }} " rel="{{ link.rel }} " />
{% endfor %} 

<link href='//fonts.googleapis.com/css?family=Open+Sans:400,300italic,400italic,600,600italic' rel='stylesheet' type='text/css' />
<link href='//fonts.googleapis.com/css?family=Crete+Round' rel='stylesheet' type='text/css' />
<link href="{{ templateResource('/stylesheet/style.response.css') }}" rel="stylesheet" type='text/css' />

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script type="text/javascript" src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<!-- fav -->

{% for style in styles %} 
<link rel="{{ style.rel }} " type="text/css" href="{{ style.href }} " media="{{ style.media }} " />
{% endfor %}

<script type="text/javascript" src="{{ ssl ? 'https': 'http'}}://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript">
if (typeof jQuery == 'undefined') {
   var include = '\x3Cscript type="text/javascript" src="{{ templateResource("/javascript/jquery-1.11.0.min.js") }} ">\x3C/script>';
   document.write(include);
}
</script>
<script type="text/javascript" src="{{ templateResource('/javascript/bootstrap.min.js') }} "></script>
<script type="text/javascript" src="{{ templateResource('/javascript/jquery-migrate-1.2.1.min.js') }}"></script>
<script type="text/javascript" src="{{ templateResource('/javascript/common.js') }} "></script>

{% for script in scripts %} 
<script type="text/javascript" src="{{ script }} "></script>
{% endfor %}

<script type="text/javascript">
	$(document).on('click', 'a.productcart', function () {
		var item = $(this);
		//check if href provided for product details access
		if (item.attr('href') && item.attr('href') != '#') {
			return true;
		}

		if (item.attr('data-id')) {
			$.ajax({
				url: '{{ cart_ajax_url }} ',
				type: 'GET',
				dataType: 'json',
				data: {product_id: item.attr('data-id')},
				success: function (data) {
                    var alert_msg = '<div class="added_to_cart pull-right"> \
                    		<a href="{{ cart_url }}" title="{{ text_add_cart_confirm }} "> \
                    		<i class="fa fa-check"></i></a> \
                    		</div>';
					item.closest('.product-item .pricetag').prepend(alert_msg);

					//topcart
					$('.topcart .dropdown-toggle span').first().html(data.item_count);
					$('.topcart .dropdown-toggle .cart_total').html(data.total);
					if ($('#top_cart_product_list')) {
						$('#top_cart_product_list').html(data.cart_details);
					}
					;
				}
			});
		}
		return false;
	});

	$(document).on('click', 'a.call_to_order', function () {
		goTo('{{ call_to_order_url }}');
		return false;
	});
</script>
{{ _this.getHookVar('vnc_head') }}

</head>
<body>
{% if maintenance_warning %} 
	<div class="alert alert-warning">
	 	<button type="button" class="close" data-dismiss="alert">&times;</button>
 		<strong>{{ maintenance_warning }}</strong>
 	</div>
{% endif %} 
