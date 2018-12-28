<div class="page-content-wrapper">
                <div class="page-content">
                            <div class="row" >
                            <div class="col-md-12">
                                <div class="portlet light portlet-fit portlet-form bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <span class="caption-subject font-red sbold uppercase">修改资料 &nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                            <div class="form-body">
  
<form class="layui-form form-horizontal" method="post" action="<?=links('info','save','edit')?>">
<div class="form-group">
<label class="control-label col-md-3">账号
<span class="required">  </span>
</label>
<div class="col-md-6">
<input class="form-control"  type="text" value="<?=$user->name?>" disabled>
</div>
</div>

<div class="form-group">
<label class="control-label col-md-3">邮箱
<span class="required">  </span>
</label>
<div class="col-md-6">
<input type="text" name="email" required lay-verify="email" placeholder="请输入您的邮箱" autocomplete="off"  class="form-control"  value="<?=$user->email?>">
</div>
</div>

<div class="form-group">
<label class="control-label col-md-3">QQ号码
<span class="required">  </span>
</label>
<div class="col-md-6">
<input type="text" class="form-control" name="qq" placeholder="请输入您的QQ号码" value="<?=$user->qq?>">
</div>
</div>

    <div class="form-group">
<label class="control-label col-md-3">网址域名
<span class="required">  </span>
</label>
<div class="col-md-6">
<input type="text" name="url" required lay-required="" placeholder="" value="<?=$user->url?>"  class="form-control">
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
    $('#b3').addClass('active');
    $('#b2').addClass('open');
    $("#idall").css('display','block');
</script>
