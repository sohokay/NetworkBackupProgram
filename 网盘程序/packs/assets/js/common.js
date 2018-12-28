var element,form,layer;
layui.use(['element','form','layer'], function(){
	element = layui.element;
	form = layui.form;
	layer = layui.layer;
	form.on('submit(*)', function(data){
		var index = layer.load(1);
		$.post(data.form.action, data.field, function(d) {
			if(d.code == 1){
				layer.msg(d.msg,{icon:1});
				setTimeout(function(){
					window.location.href = d.url;
				},1500);
			}else{
				layer.msg(d.msg,{icon:2});
				if(d.msg == '验证码不正确'){
					reloadCodes();
				}
			}
			layer.close(index);
		},"json");
		return false;
	});
	//搜索
    $('.searchbut').on('click', function() {
	    var key = $('#key').val();
	    if(key == ''){
	    	layer.msg('请输入要搜索的关键字',{icon:2});
	    	return false;
	    }else{
	    	var link = $(this).attr('link');
	    	window.location.href = link+'?key='+key;
	    }
    });
});
function del_one(url,id){
	if(arguments[2]){
		var title = arguments[2];
	}else{
		var title = '确定要删除该列数据吗？';
	}
	if(!id){
		layer.msg('参数错误，请刷新重试',{icon:2});
	}else{
		layer.confirm(title, {
			title:'删除提示',
		    btn: ['确定', '取消'], //按钮
		    shade:0.001
		}, function(index) {
		    $.post(url, {
				id:id
			}, function(data) {
				if(data.error == 0){
					layer.msg('恭喜你，删除成功',{icon:1});
					$('#row_'+id).remove();
					if(typeof(data.info.turn) != undefined && data.info.turn ==1){
						setTimeout(function(){
							location.href = data.info.url;
						},1500);
					}
				}else{
					layer.msg(data.info,{icon:2});
				}
			},"json");
		}, function(index) {
		    layer.close(index);
		});
	}
}
function get_open(url,title,w,h){
	layer.open({
		title:title,
		type: 2,
		area: [w, h],
		closeBtn: 1, //不显示关闭按钮
		shade: 0.01,
		shadeClose: true, //开启遮罩关闭
		content: url
	});
}
function reloadCodes(){
    $('.verifyimg').attr('src', "/index.php/code?" + Math.random());
}
function getajax(url,ac){
	if(ac == 'del'){
		layer.confirm('确定要操作吗？', {
			title:'友情提示',
		    btn: ['确定', '取消'], //按钮
		    shade:0.001
		}, function(index) {
		    $.get(url, function(data) {
				if(data.code == 1){
					layer.msg(data.msg,{icon:1});
					setTimeout(function(){
						location.reload();
					},1500);
				}else{
					layer.msg(data.msg,{icon:2});
				}
			},"json");
		}, function(index) {
		    layer.close(index);
		});
	}else{
	    $.get(url, function(data) {
			if(data.code == 1){
				layer.msg(data.msg,{icon:1});
			}else{
				layer.msg(data.msg,{icon:2});
			}
		},"json");
	}
}