 <link href="/packs/assets/css/faq.min.css" rel="stylesheet" type="text/css" />
 <div class="page-content-wrapper">
                <div class="page-content">
                            <div class="row" >
                            <div class="col-md-12">
                                <!-- BEGIN VALIDATION STATES-->
                                <div class="portlet light portlet-fit portlet-form bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-question-circle fa-lg font-blue"></i>
                                            <span class="caption-subject  font-blue sbold uppercase">使用说明 &nbsp;</span>
 
                                              <span class="caption-helper"> （如有更多问题，请加入站长互助QQ群：<?=Admin_Qun?>） </span>
 
                                        </div>
 
                                    </div>
                                    <div class="portlet-body">
                     <div class="faq-page faq-content-1">
            
                        <div class="faq-content-container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="faq-section">
                                      
                                        <div class="panel-group accordion faq-content" id="accordion1">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <i class="fa fa-circle"></i>
                                                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse_1"> 如何使用"我的分类"功能?</a>
                                                    </h4>
                                                </div>
                                                <div id="collapse_1" class="panel-collapse collapse">
                                                    <div class="panel-body">
                                                        <p>"我的分类"分为一级分类和二级分类。一级分类为父栏目，二级分类为子栏目。</p>
                                                        <p>在创建分类上级分类为空时默认创建父栏目，选择父栏目时创建的为子栏目。</p>
                                                        <p>视频只能发布在子栏目内，点击子栏目链接可看到该子栏目下所有的视频。个人分类仅自己可见。</p>
                                                        <p>该功能为方便站长对视频分类、检索，如上传"人民的名义"全集，可新建父栏目"国产电视剧"，再在此父栏目下新建子栏目"人民的名义全集"，上传所有视频时私人分类选项选择"国产电视剧"-"人民的名义全集"。</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <i class="fa fa-circle"></i>
                                                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse_2"> 如何正确使用视频、预览图API接口？</a>
                                                    </h4>
                                                </div>
                                                <div id="collapse_2" class="panel-collapse collapse">
                                                    <div class="panel-body">
                                                        <p> 为防止CDN域名被墙，现全部改用API调用视频。当视频源地址被屏蔽时，官方后台更换域名即可，再无须站长批量替换数据库字段。</p>
                                                        <p> 例：<?=links('play','index','b0f76c8d82d8')?> 为一个视频的API接口。其中：<?=links('play','index')?> 为固定接口，b0f76c8d82d8为内容值（视频ID）。</p>
                                                        <p>     站长只需和以往一样在调用视频时填写视频API接口地址，该地址永不失效且不会被屏蔽。</p>
                                                        <p> 预览图API接口同理，在网页代码src=""处填写接口地址即可。预览图总共为<?=Jpg_Num?>张，默认调用第一张图片。</p>
                                                        <p> 如想调用其他图片请把“1.jpg”改成“2.jpg”,如调用某视频第二章预览图地址：<?=m3u8_link('b0f76c8d82d8','1523437407','pic',2)?>。</p>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <i class="fa fa-circle"></i>
                                                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse_3"> 上传类别分类与内容限制 </a>
                                                    </h4>
                                                </div>
                                                <div id="collapse_3" class="panel-collapse collapse">
                                                    <div class="panel-body">
                                                        <p> 为方便管理员审核内容，上传视频时必须按照视频内容选择对应类别。短片、搞笑小视频等归为"其他视频"，伦理片一律归为"成人视频"。</p>
                                                        <p> 上传的视频中不得带有明显广告水印，引诱文字水印，内置推广视频等。</p>
                                                        <p> 视频内容必须遵循美国法律和联邦宪法，严禁上传涉及幼兽、恐暴、宗教、政治、反动等国际上禁止的内容。</p>
                                                        <p> 违反者我们会第一时间永久封停该帐号，并配合IDC公司将涉事者相关资料递交给当地警局处理。</p>
                                                    </div>
                                                </div>
                                            </div>
                              
                                        </div>
                                    </div>
                         
                                </div>
                           
                            </div>
                        </div>
                    </div>
                                
                                </div>
                                <!-- END VALIDATION STATES-->
                            </div>
                        </div>
   
                <!-- END CONTENT BODY -->
            </div>
            <!-- END CONTENT -->
            <!-- BEGIN QUICK SIDEBAR -->
  
            <!-- END QUICK SIDEBAR -->
        </div>
 <script type="text/javascript">
    $('#b6').addClass('active');
</script>