$.validator.setDefaults({
	/*highlight : function(e) {
		$(e).closest(".form-group").removeClass("has-success").addClass(
				"has-error")
	},
	success : function(e) {
		e.closest(".form-group").removeClass("has-error").addClass(
				"has-success")
	},*/
	errorElement : "span",
	errorPlacement : function(e, r) {
			e.appendTo(r.is(":radio") || r.is(":checkbox") ? r.parent().parent()
					.parent() : r.parent())
	},
	errorClass : "help-block m-b-none text-danger",
	validClass : "help-block m-b-none"
});

//两位正小数   
jQuery.validator.addMethod("twoDecimalPlaces", function(value, element) {   
    var regex = /^[0-9]+(\.[0-9]{0,2})?$/;
    return this.optional(element) || (regex.test(value));
}, "请输入非负数,小数后只能有两位");

//验证正整数  
jQuery.validator.addMethod("IsIntegerPositive", function(value, element) {   
	var regex = /^[0-9]*[1-9][0-9]*$/;
    return this.optional(element) || (regex.test(value));
}, "请输入正整数");