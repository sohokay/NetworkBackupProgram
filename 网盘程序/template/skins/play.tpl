<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <title><?=$title?></title>
        <script type="text/javascript" src="/packs/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="/packs/ckplayer/ckplayer.js"></script>
		<style>html,body,div{width:100%;height:100%;margin:0;padding:0;}</style>
    </head>
    <body>
        <div id="video"></div>
        <script type="text/javascript">
            var videoObject = {
                container: '#video',
                variable: 'player',
                video:'<?=$m3u8url?>',
				poster:'<?=$picurl?>',
				autoplay:true
            };
            var player = new ckplayer(videoObject);
        </script>
    </body>
</html>