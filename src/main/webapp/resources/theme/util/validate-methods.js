//判断条件查询false才会显示错误信息
// 判断手机号码是否正确
jQuery.validator.addMethod("isPhoneNumber",function (value, element) {
    var length = value.length;
    var rule = /^1(3|4|5|7|8)+\d{9}$/;
    return this.optional(element) || (rule.test(value) && length == 11)
},"请填写正确的手机号");

// 判断输入的内容是否包含空格
jQuery.validator.addMethod("isContainBlank",function (value, element) {
    return this.optional(element) || !(value.indexOf(" ") >= 0)
},"不可包含空格");

// 判断用户更新地址的时候有没有选择地区
jQuery.validator.addMethod("isArea",function (value, element) {
    return this.optional(element) || !(value == "市辖区")
},"请选择地区");

// 判断联系方式是否正确，可以输入手机号码也可以输入电话
jQuery.validator.addMethod("isPhone",function (value, element) {
    var phoneNumberRule = /^1(3|4|5|7|8)+\d{9}$/;
    var telephoneRule =/^0(([1-9]\d)|([3-9]\d{2}))\d{8}$/;
    return this.optional(element) || phoneNumberRule.test(value) || telephoneRule.test(value)
},"请填写正确的联系方式");

// 判断邮政编码,如果不知道邮政编码可输入000000
jQuery.validator.addMethod("isZipCode",function (value, element) {
    var rule =  /^[1-9][0-9]{5}$/;
    return this.optional(element) || (rule.test(value) || value == "000000")
},"请输入正确的邮政编码");



