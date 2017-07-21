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


