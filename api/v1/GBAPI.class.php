<?php
error_reporting(E_ALL);
require_once 'API.class.php';
require_once 'NotORM.php';

class GBAPI extends API{
  protected $User;
  protected $db;
  private $cleaners = array(
    'string'=>array(),
    'list'=>array(),
    'date'=>array(),
    'int'=>array(),
    'bool'=>array()
  );

  public function __construct($request, $origin){
    parent::__construct($request);
    $username = "promo";
    $password = "pass";
    $database = "db";
    $host = "localhost";
    $dsn = "mysql:dbname=$database;host=$host";
    $connection = new PDO($dsn,$username,$password);
    $structure = new NotORM_Structure_Discovery($connection);
    $cache = new NotORM_Cache_File('notorm.cache');
    $this->db = new NotORM($connection,$structure,$cache);
    $this->db->debug = function($query, $parameters){
      var_dump($query);
      echo "<br>";
      var_dump($parameters);
      echo "<br>";
    };
    $this->db->debug = false;
  }

  protected function sites(){
    $sites = $this->db->tblPaysites();
    $selects = array(
      'paysiteid',
      'paysitename',
      'shortname',
      'flag_hasrss',
      'flag_inadmin'
    );
    $this->cleaners = array(
      'string'=>array(),
      'list'=>array(),
      'date'=>array(),
      'int'=>array('paysiteid'),
      'bool'=>array('flag_hasrss','flag_inadmin')
    );
    $this->set_selects($sites,$selects,$this->request);
    if(isset($this->args[0])){
      $id = $this->args[0];
      $sites->where('paysiteid', $id);
      $data = $this->get_clean_results($sites);
      return $data[0];
    }else{
      $this->set_order_and_filter($sites,$selects,$this->request);
      $total = count($sites);
      $paging = $this->set_paging($sites,$total,$this->request);
      $this->response_type = 'json';
      return $this->progressive_json($paging,$total,$this->get_results($sites));
    }
  }

  protected function stars(){
    $models = $this->db->tblModels();
    $selects = array(
      'modelid',
      'modelname'
    );
    $this->cleaners = array(
      'string'=>array('modelname'),
      'list'=>array(),
      'date'=>array(),
      'int'=>array('modelid'),
      'bool'=>array()
    );
    $this->set_selects($models,$selects,$this->request);
    if(isset($this->args[0])){
      $id = $this->args[0];
      $models->where('modelid', $id);
      $data = $this->get_clean_results($models);
      return $data[0];
    }else{
      $this->set_order_and_filter($models,$selects,$this->request);
      $total = count($models);
      $paging = $this->set_paging($models,$total,$this->request);
      $this->response_type = 'json';
      return $this->progressive_json($paging,$total,$this->get_results($models));
    }
  }

  protected function packs(){
    $packs = $this->db->tblPacks();
    $selects = array(
      'packid',
      'paysiteid',
      'packdate',
      'updated_at',
      'title',
      '`desc`',
      'marketing',
      'mpa_fhg',
      'mpa_va',
      'mpa_pic',
      'vist_id',
      'flag_pub',
      'flag_email',
      'flag_hasflv',
      'flag_haszip',
      'flag_mp4only',
      'flag_hastube',
      'flag_istg',
      'flv_formats',
      'flv_scales',
      'flv_sizes',
      'tube_template',
      'contentfoldersuffix'
    );
    $this->cleaners = array(
      'string'=>array(
        'mpa_fhg',
        'mpa_va',
        'mpa_pic',
        'vist_id'
      ),
      'list'=>array(
        'flv_formats',
        'flv_scales',
        'flv_sizes',
        'marketing'
      ),
      'date'=>array(
        'packdate',
        'updated_at'
      ),
      'int'=>array('paysiteid'),
      'bool'=>array(
        'flag_pub',
        'flag_email',
        'flag_hasflv',
        'flag_haszip',
        'flag_mp4only',
        'flag_hastube',
        'flag_istg'
      )
    );
    $this->set_selects($packs,$selects,$this->request);
    if($this->verb != ''){
      $id = $this->verb;
      $packs->where('packid', $id);
      $data = $this->get_clean_results($packs);
      return $data[0];
    }else{
      $this->set_order_and_filter($packs,$selects,$this->request);
      $total = count($packs);
      $paging = $this->set_paging($packs,$total,$this->request);
      $this->response_type = 'json';
      return $this->progressive_json($paging,$total,$this->get_results($packs));
    }
  }

  private function get_results($table){
    return array_map('iterator_to_array', iterator_to_array($table));
  }

  private function clean_result($el){
    foreach ($this->cleaners['list'] as $col) {
      if(isset($el[$col])){
        $vals = explode(',', $el[$col]);
        $el[$col] = array();
        foreach ($vals as $val) {
          $val = trim($val);
          if($val!="") $el[$col][] = strtolower($val);
        }
      }
    }
    // foreach ($this->cleaners['date'] as $col) {
    //   if(isset($el[$col])){
    //     $dt = new DateTime($el[$col]);
    //     $el[$col] = $dt->getTimestamp();
    //   }
    // }
    foreach ($this->cleaners['int'] as $col) {
      if(isset($el[$col])) $el[$col] = intval($el[$col]);
    }
    foreach ($this->cleaners['string'] as $col) {
      if(isset($el[$col])) $el[$col] = trim($el[$col]);
    }
    foreach ($this->cleaners['bool'] as $col) {
      if(isset($el[$col])) $el[$col] = intval($el[$col])==1;
    }
    return $el;
  }

  private function get_clean_results($table){
    return array_map(array($this,'clean_result'),$this->get_results($table));
  }

  private function set_selects(&$table, $selects = array(), $request = array()){
    if(isset($request['limit'])){
      // var_dump($request['limit']);
      if(is_array($request['limit'])){
        $limited_select = $request['limit'];
      }else{
        $limited_select = explode(',',urldecode($request['limit']));
      }
      foreach ($limited_select as $value) {
        if($value == 'desc') $value = '`desc`';
        if(in_array($value, $selects)){
          $table->select($value);
        }
      }
    }else{
      $excl = isset($request['exclude'])?explode(',',$request['exclude']):array();
      foreach ($selects as $value) {
        if(!in_array(($value=='`desc`'?'desc':$value), $excl)) $table->select($value);
      }
    }
  }

  private function set_order_and_filter(&$table,$selects = array(), $request = array()){
    if(isset($request['sorting'])){
      foreach ($request['sorting'] as $key => $value) {
        $table->order($key." ".strtoupper($value));
      }
    }
    if(isset($request['filter'])){
      foreach ($request['filter'] as $key => $value) {
        $comparison = " LIKE ?";
        $comparitor = "%".$value."%";
        if(isset($request['filter_exact'])){
          $comparison = " = ?";
          $comparitor = $value;
        }
        if($key == 'desc') $key = '`desc`';
        if(in_array($key, $selects)){
          if(in_array($key,$this->cleaners['bool'])){
            $table->where($key, (strtolower($value) == 'true'?1:0));
            break;
          }
          $table->where($key.$comparison,$comparitor);
        }
      }
    }
  }

  private function set_paging(&$table,$total=null, $request){
    if($total==null) $total = count($table);
    if(!isset($request['count'])) $request['count']=$total;
    $count = intval($request['count']);
    $page = 1;
    if(isset($request['page'])){
      $page = intval($request['page']);
    }
    $offset = $count*($page-1);
    $table->limit($count,$offset);
    return array("count" =>$count, "page"=>$page);
  }

  private function echo_data(){
    return Array(
      'method'=> $this->method,
      'args'=> $this->args,
      'endpoint'=> $this->endpoint,
      'verb'=> $this->verb,
      'request'=> $this->request,
    );
  }

  private function progressive_json($paging,$total,$results){
    $output = '{';
    $output.= '"count":'.$paging['count'].',';
    $output.= '"page":'.$paging['page'].',';
    $output.= '"total":'.$total.',';
    $output.= '"result":[';
    $start = true;
    foreach ($results as $result) {
      if(!$start) $output.=',';
      $start = false;
      $output.=json_encode($this->clean_result($result));
    }
    $output.= ']';
    $output.= '}';
    return $output;
  }
}

?>