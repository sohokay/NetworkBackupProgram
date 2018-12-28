<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Setting extends CI_Controller {
	function __construct(){
	    parent::__construct();
		//加载会员模型
		$this->load->model('admin');
        //判断登陆
		$this->admin->login();
        //当前模版
		$this->load->get_templates();
	}
	//修改系统配置
	public function index(){
		//字幕内容
		$str = file_get_contents(FCPATH.'packs/ffmpeg/zimu.ass');
		$arr = explode('[Events]', $str);
		$zimu = isset($arr[1]) ? $arr[1] : '';
		$data['zimu'] = str_replace("\r\n","",str_replace('{\b0}{\fs}{\fn}','',$zimu));
		$this->load->view('setting.tpl',$data);
	}
	public function save(){
		//基本设置
		$Web_Name = $this->input->get_post('Web_Name',true);
		$Web_Path = $this->input->get_post('Web_Path',true);
		$Web_Url = $this->input->get_post('Web_Url',true);
		$Web_Zm_Url = $this->input->get_post('Web_Zm_Url',true);
		$Web_M3u8_Url = $this->input->get_post('Web_M3u8_Url',true);
		$Web_Pic_Url = $this->input->get_post('Web_Pic_Url',true);
		$Web_Reg = (int)$this->input->get_post('Web_Reg',true);
		$Web_Gg = str_encode($this->input->get_post('Web_Gg'));

		$Web_Url = str_replace(array('http://','/'),'',$Web_Url);
		$Web_Zm_Url = str_replace(array('http://','/'),'',$Web_Zm_Url);
		$Web_M3u8_Url = str_replace(array('http://','/'),'',$Web_M3u8_Url);
		$Web_Pic_Url = str_replace(array('http://','/'),'',$Web_Pic_Url);

		//截图动图
		$Jpg_On = intval($this->input->get_post('Jpg_On',true));
		$Jpg_Num = intval($this->input->get_post('Jpg_Num',true));
		$Jpg_Time = intval($this->input->get_post('Jpg_Time',true));
		$Jpg_Size = $this->input->get_post('Jpg_Size',true);
		if($Jpg_Num == 0) $Jpg_Num = 1;
		if($Jpg_Num > 20) getjson('抱歉，截图最多只能20张');
		if($Jpg_On==0){
			$jpgarr = explode('x', $Jpg_Size);
			if(!empty($Jpg_Size) && (sizeof($jpgarr)!=2 || intval($jpgarr[0])<1 || intval($jpgarr[1])<1)){
				getjson('截图尺寸格式不正确');
			}
		}
		//转码设置
		$Zm_Time = intval($this->input->get_post('Zm_Time',true));
		$Zm_Size = $this->input->get_post('Zm_Size',true);
		$Zm_Dir = $this->input->get_post('Zm_Dir',true);
		$Zm_Kbps = $this->input->get_post('Zm_Kbps',true);
		$Zm_Preset = $this->input->get_post('Zm_Preset',true);

		if(empty($Zm_Dir)) getjson('切片目录不能留空');
		$muarr = explode('x', $Zm_Size);
		if(!empty($Zm_Size) && (sizeof($muarr)!=2 || intval($muarr[0])<1 || intval($muarr[1])<1)){
			getjson('切片视频尺寸格式不正确');
		}

		$Zm_Sy = intval($this->input->get_post('Zm_Sy',true));
		$Zm_Sylt = $this->input->get_post('Zm_Sylt',true);
		$Zm_Zm = intval($this->input->get_post('Zm_Zm',true));
		$Zm_Zmtxt = $this->input->get_post('Zm_Zmtxt');
		if($Zm_Zm == 1){
			if(empty($Zm_Zmtxt)) getjson('字幕内容不能为空');
		}
		if(substr($Zm_Zmtxt,0,9) != 'Dialogue:'){
			getjson('字幕内容格式错误');
		}
		//修改字幕内容
		$str = file_get_contents(FCPATH.'packs/ffmpeg/zimu.ass');
		$zmarr = explode('Dialogue:',$Zm_Zmtxt);
		unset($zmarr[0]);
		$Zm_Zmtxt = "Dialogue:".implode("\r\n{\\b0}{\\fs}{\\fn}\r\nDialogue:",$zmarr);
		$zimu = current(explode('[Events]', $str))."[Events]\r\n".$Zm_Zmtxt;
		write_file(FCPATH.'packs/ffmpeg/zimu.ass', $zimu);

		if($Zm_Sy == 1){
			$wmarr = explode(':', $Zm_Sylt);
			if(sizeof($wmarr)<2) getjson('水印间距格式不正确');
			$Zm_Sylt = intval($wmarr[0]).':'.intval($wmarr[1]);
		}

		$Up_Dir = $this->input->get_post('Up_Dir',true);
		$Up_Ext = $this->input->get_post('Up_Ext',true);
		if(empty($Up_Dir)) getjson('上传路径不能为空');
		if(empty($Up_Ext)) getjson('支持的上传格式不能为空');

		$Del_Mp4 = (int)$this->input->get_post('Del_Mp4',true);
		$Del_M3u8 = (int)$this->input->get_post('Del_M3u8',true);

		$Admin_QQ = $this->input->get_post('Admin_QQ',true);
		$Admin_Qun = $this->input->get_post('Admin_Qun',true);
		$Admin_Count = str_encode($this->input->get_post('Admin_Count'));


		//配置字符串
		$strs = "<?php"."\r\n";
        $strs .= "define('Web_Name','".$Web_Name."'); //站点名称\r\n";
        $strs .= "define('Web_Url','".$Web_Url."'); //站点域名\r\n";
        $strs .= "define('Web_Zm_Url','".$Web_Zm_Url."'); //转码域名\r\n";
        $strs .= "define('Web_M3u8_Url','".$Web_M3u8_Url."'); //M3u8域名\r\n";
        $strs .= "define('Web_Pic_Url','".$Web_Pic_Url."'); //图片域名\r\n";
        $strs .= "define('Web_Path','".$Web_Path."'); //站点路径\r\n";
        $strs .= "define('Web_Reg',".$Web_Reg.");  //会员注册状态，0审核，1待审\r\n";
        $strs .= "define('Web_Gg','".$Web_Gg."');  //网站公告\r\n";

        $strs .= "define('Up_Dir','".$Up_Dir."'); //上传源文件保存路径\r\n";
        $strs .= "define('Up_Ext','".$Up_Ext."'); //支持的上传格式\r\n";

        $strs .= "define('Del_Mp4',".$Del_Mp4."); //删除视频是否删除源文件\r\n";
        $strs .= "define('Del_M3u8',".$Del_M3u8."); //删除视频是否删除切片资源\r\n";

        $strs .= "define('Zm_Dir','".$Zm_Dir."');  //切片保存目录\r\n";
        $strs .= "define('Zm_Preset','".$Zm_Preset."'); //切片优先方式\r\n";
        $strs .= "define('Zm_Time',".$Zm_Time.");  //每个TS的时长秒数\r\n";
        $strs .= "define('Zm_Kbps','".$Zm_Kbps."');  //切片码率\r\n";
        $strs .= "define('Zm_Size','".$Zm_Size."');  //切片尺寸\r\n";
        $strs .= "define('Zm_Zm',".$Zm_Zm.");  //是否启用字幕。0关闭，1启用\r\n";
        $strs .= "define('Zm_Sy',".$Zm_Sy.");  //水印开关，0关闭1左上2右上3左下4右下\r\n";
        $strs .= "define('Zm_Sylt','".$Zm_Sylt."');  //左上距离边界位置\r\n";

        $strs .= "define('Jpg_On',".$Jpg_On.");  //截图开关，1打开0关闭\r\n";
        $strs .= "define('Jpg_Num',".$Jpg_Num.");  //截图张数\r\n";
        $strs .= "define('Jpg_Time',".$Jpg_Time.");  //间隔秒数\r\n";
        $strs .= "define('Jpg_Size','".$Jpg_Size."');  //截图尺寸\r\n";

        $strs .= "define('Admin_QQ','".$Admin_QQ."'); //联系QQ\r\n";
        $strs .= "define('Admin_Qun','".$Admin_Qun."'); //联系群\r\n";
        $strs .= "define('Admin_Count','".$Admin_Count."'); //统计代码";

        //写文件
        if (!write_file(FCPATH.'sys/libs/config.php', $strs)){
            getjson('抱歉，sys/libs/config.php文件，没有修改权限');
        }else{
        	$info['url'] = site_url('setting').'?v='.rand(1000,1999);
            $info['msg'] = '恭喜您，修改成功';
        	getjson($info,1);
        }
	}
}
