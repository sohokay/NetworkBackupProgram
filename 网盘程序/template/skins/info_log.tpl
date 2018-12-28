<div class="page-content-wrapper">
                <div class="page-content">
                      <div class="row">
                        <div class="col-md-12">
                            <!-- Begin: life time stats -->
                            <div class="portlet light bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <span class="caption-subject font-red sbold uppercase">登录日志 &nbsp;</span>
                                        </div>
 
                                    </div>
                    
                                <div class="portlet-body">
 
 
                                        <div class="tab-content">
                                            
                                            <div class="tab-pane active" id="overview_1">
                                                    <table class="table table-striped table-hover table-bordered">
                                                        <thead>
                                                            <th>序号</th>
                                                            <th>IP地址</th>
                                                            <th>参考地点</th>
                                                            <th>客户端详情</th>
                                                            <th>登录时间</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        <?php
                                                        foreach($log as $k=>$row){
                                                            echo '<tr><td>'.($k+1).'</td><td>'.$row->ip.'</td><td>Unknown</td><td>'.$row->info.'</td><td>'.date('Y-m-d H:i:s',$row->addtime).'</td></tr>';
                                                        }
                                                        ?>
                                                        </tbody>
                                                    </table>
               
               
                              <div class="row">
                      
                                       <div class="col-md-offset-4 col-md-8">
        
        
                                        <ul class="pagination"  style="float:right">
                                            <?=$pages?>
                                        </ul>
                                    </div>
                                     
                                                </div>
                                            </div>
                                        
                                        </div>
                                    </div>
                                    
                                </div>
               
                            
                            </div>
                            <!-- End: life time stats -->
                            
                        </div>

                    </div>
            
                    <!-- END PAGE BASE CONTENT -->
                </div>
            <!-- END CONTENT -->
            <!-- BEGIN QUICK SIDEBAR -->
  
            <!-- END QUICK SIDEBAR -->
        </div>
<script type="text/javascript">
    $('#b5').addClass('active');
    $('#b2').addClass('open');
    $("#idall").css('display','block');
</script>
