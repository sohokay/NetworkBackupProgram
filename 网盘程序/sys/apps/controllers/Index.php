<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Index extends CI_Controller {
	function __construct(){
	    parent::__construct();
        //当前模版
		$this->load->get_templates();
	}

	public function index(){
		header("location:".links('vod'));
		exit;
	}
}
