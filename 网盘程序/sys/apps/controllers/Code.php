<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Code extends CI_Controller {

	function __construct(){
		parent::__construct();
	}

	public function index()
	{
		//主要参数
		$size=(int)$this->input->get('size', TRUE);
		$w=(int)$this->input->get('w', TRUE);
		$h=(int)$this->input->get('h', TRUE);
		$type=$this->input->get('type', TRUE);
		$font_size   = !empty($size) ? $size : 22;
		$img_height  = !empty($h) ? $h : 38;
		$img_width   = !empty($w) ? $w : 110;
		$use_boder   = TRUE;
		$filter_type = 5;
		$word_type  = !empty($type) ? $type : 2;   // 1:数字  2:英文
		$font_file   = BASEPATH.'fonts/texb.ttf';

		//创建图片，并设置背景色
		$im = @imagecreate($img_width, $img_height);
		imagecolorallocate($im, 255,255,255);
		
		//文字随机颜色
		$fontColor[]  = imagecolorallocate($im, 0x15, 0x15, 0x15);
		$fontColor[]  = imagecolorallocate($im, 0x95, 0x1e, 0x04);
		$fontColor[]  = imagecolorallocate($im, 0x93, 0x14, 0xa9);
		$fontColor[]  = imagecolorallocate($im, 0x12, 0x81, 0x0a);
		$fontColor[]  = imagecolorallocate($im, 0x06, 0x3a, 0xd5);
		
		//获取随机字符
		$rndstring  = '';
		for($i=0; $i<4; $i++)
		{
				if ($word_type == 1){
					$c = chr(mt_rand(48, 57));
				} else if($word_type == 2){ 
					$c = chr(mt_rand(65, 90));
					if( $c=='I' ) $c = 'P';
					if( $c=='O' ) $c = 'N';
				}
				$rndstring .= $c;
		}
		$this->cookie->set('codes',strtolower($rndstring),1800+time());
		$rndcodelen = strlen($rndstring);

		//背景横线
		$lineColor1 = imagecolorallocate($im, 0xda, 0xd9, 0xd1);
		for($j=3; $j<=$img_height-3; $j=$j+3)
		{
				imageline($im, 2, $j, $img_width - 2, $j, $lineColor1);
		}
		
		//背景竖线
		$lineColor2 = imagecolorallocate($im, 0xda,0xd9,0xd1);
		for($j=2;$j<100;$j=$j+6)
		{
				imageline($im, $j, 0, $j+8, $img_height, $lineColor2);
		}

		//画边框
		if( $use_boder && $filter_type == 0 )
		{
				$bordercolor = imagecolorallocate($im, 0x9d, 0x9e, 0x96);
				imagerectangle($im, 0, 0, $img_width-1, $img_height-1, $bordercolor);
		}
		
		//输出文字
		$lastc = '';
		for($i=0;$i<$rndcodelen;$i++)
		{
				$bc = mt_rand(0, 1);
				$rndstring[$i] = strtoupper($rndstring[$i]);
				$c_fontColor = $fontColor[mt_rand(0,4)];
				$y_pos = $i==0 ? 6 : $i*($font_size+2);
				$c = mt_rand(0, 15);
				@imagettftext($im, $font_size, $c, $y_pos, 30, $c_fontColor, $font_file, $rndstring[$i]);
				$lastc = $rndstring[$i];
		}
		
		//图象效果
		switch($filter_type)
		{
				case 1:
						imagefilter ( $im, IMG_FILTER_NEGATE);
						break;
				case 2:
						imagefilter ( $im, IMG_FILTER_EMBOSS);
						break;
				case 3:
						imagefilter ( $im, IMG_FILTER_EDGEDETECT);
						break;
				default:
						break;
		}

		header("Pragma:no-cache\r\n");
		header("Cache-Control:no-cache\r\n");
		header("Expires:0\r\n");

		//输出特定类型的图片格式，优先级为 gif -> jpg ->png
		//dump(function_exists("imagejpeg"));
		
		if(function_exists("imagejpeg"))
		{
				header("content-type:image/jpeg\r\n");
				imagejpeg($im);
		}
		else
		{
				header("content-type:image/png\r\n");
				imagepng($im);
		}
		imagedestroy($im);
		exit();
	}
}

