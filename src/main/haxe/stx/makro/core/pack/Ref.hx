package stx.makro.core.pack;

import stx.makro.core.tdef.Ref in RefT;

@:forward abstract Ref<T>(RefT<T>) from RefT<T> to RefT<T>{
  public function new(self) this = self;
  static public function lift<T>(self:RefT<T>):Ref<T> return new Ref(self);
  

  

  public function prj():RefT<T> return this;
  private var self(get,never):Ref<T>;
  private function get_self():Ref<T> return lift(this);
}