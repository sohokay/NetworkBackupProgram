<div class="page-content-wrapper">
                <div class="page-content">
                            <div class="row" >
                            <div class="col-md-12">
                                <div class="portlet light portlet-fit portlet-form bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <span class="caption-subject font-red sbold uppercase">修改密码 &nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                            <div class="form-body">
  
<form class="layui-form form-horizontal" method="post" action="<?=links('info','save','pass')?>">
<div class="form-group">
<label class="control-label col-md-3">原密码
<span class="required">  </span>
</label>
<div class="col-md-6">
<input type="password" name="pass1" placeholder="请输入您的原密码" autocomplete="off" class="form-control" required lay-verify="">
</div>
</div>

<div class="form-group">
<label class="control-label col-md-3">新密码
<span class="required">  </span>
</label>
<div class="col-md-6">
<input type="password" class="form-control" name="pass2" placeholder="请输入您的新密码" autocomplete="off" required lay-required="">
</div>
</div>

    <div class="form-group">
<label class="control-label col-md-3">确定密码
<span class="required">  </span>
</label>
<div class="col-md-6">
<input type="password" name="pass3" placeholder="请确定您的新密码" class="form-control" autocomplete="off" required lay-required="">
</div>
</div>

 <div class="form-actions">
  <div class="row">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <button type="submit" lay-submit lay-filter="*" class="btn btn-lg green"><i class="fa fa-check"></i> 提交 </button>
                                                        <button type="reset" class="btn btn-lg grey-salsa btn-outline" ><i class="fa fa-refresh"></i> 重置</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
            </div>
        </div>
<script type="text/javascript">
    $('#b4').addClass('active');
    $('#b2').addClass('open');
    $("#idall").css('display','block');
</script>
