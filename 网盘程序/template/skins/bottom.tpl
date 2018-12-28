<div class="page-footer">
            <div class="page-footer-inner"> <script>document.write(new Date().getFullYear());</script>&copy; 版权所有
                <span><?=Web_Url?></span> &nbsp;|&nbsp;永久免费的CDN多媒体网盘
            </div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div> 
        <!-- END CONTAINER -->
        <!--[if lt IE 9]>
        <script src="/packs/assets/js/respond.min.js"></script>
        <script src="/packs/assets/js/excanvas.min.js"></script> 
        <script src="/packs/assets/js/ie8.fix.min.js"></script> 
        <![endif]-->
        <!-- BEGIN CORE PLUGINS -->
        <script src="/packs/assets/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/js.cookie.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="/packs/assets/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="/packs/assets/bootstrap-select/js/bootstrap-select.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="/packs/assets/js/app.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="/packs/assets/js/components-bootstrap-select.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="/packs/assets/js/layout.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/demo.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/quick-sidebar.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/quick-nav.min.js" type="text/javascript"></script>
		<script src="/packs/assets/js/bootstrap-modalmanager.js" type="text/javascript"></script>
		<script src="/packs/assets/js/bootstrap-modal.js" type="text/javascript"></script>
		<script src="/packs/assets/js/clipboard.min.js" type="text/javascript"></script>
		<script src="/packs/assets/js/components-clipboard.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/common.js" type="text/javascript"></script>
        <script>
        $(document).ready(function() {
            $.get('<?=links('ajax','err')?>');
            $.get('<?=links('ajax','zm')?>');
        });
        </script>
</body>
</html> 