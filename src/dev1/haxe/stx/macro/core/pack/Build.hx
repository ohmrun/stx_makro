package stx.macro.core.pack;

using Lambda;
using stx.ds.Lift;

import haxe.macro.Compiler;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;

class Build{
  var root                              : String;
  var classpaths                        : Array<String>;
  public var data(default,null)         : Dynamic;

  public function new(root,classpaths){
    this.root       = root;
    this.classpaths = classpaths;
    this.data       = {};
    var path  = root + '.haxe/';
    directory(path);
    var content         = "";
    var buildrc_path    = '${path}.buildrc'; 
    content = File.getContent(buildrc_path);
    this.data = Json.parse(content); 
    if(this.data.root == null){
      this.data.root = root;
    }
    var gen = '${path}gen';
    directory(gen);
    Compiler.addClassPath(gen);
    File.saveContent(buildrc_path,Json.stringify(data,null,"  "));
  }
  function directory(path){
    if(!FileSystem.exists(path)){
      FileSystem.createDirectory(path);
    }
  }
  function file(path){
    if(!FileSystem.exists(path)){
      File.saveContent(path,"");
    }
  }
  public function gen(){
    return '${root}.haxe/gen';
  }
  function gen_relative(path:Array<String>){
    var loc = path.join(__.sep());
    trace('$path $loc');
    return '${gen()}${__.sep()}$loc';
  }
  public function toString(){
    return 'Build:\n${Json.stringify(data,null,"  ")}';
  }
  public function getLocalSourceDirectories(){
    return classpaths.filter(
      (str) -> StringTools.startsWith(str,root)
    );
  } 
  function pack_directory(tdef){
    Lambda.fold(tdef.pack,
      (next,memo:Array<String>)-> {
        var out = memo.snoc(next); 
        directory(gen_relative(out));
        return out;
      },
      [].ds()
    );
  }
  public function deploy(tdef:TypeDefinition){
    pack_directory(tdef);
    var sp        = __.sep();
    var tpath     = tdef.pack.ds();
    var classpath = tpath.join(sp);
    //.snoc(tdef.name) 
    var file_name = gen() + sp + tpath.snoc(tdef.name).join(sp) + ".hx";
    file(file_name);
    var printer = new haxe.macro.Printer();
    var to_disk = printer.printTypeDefinition(tdef);
    trace(to_disk);
    File.saveContent(file_name,to_disk);
    var add_class_path = gen() + sp + tpath.join(sp);
    trace(gen());
    Context.defineType(tdef);
  }
}