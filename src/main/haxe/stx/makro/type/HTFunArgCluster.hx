package stx.makro.type;

@:forward abstract HTFunArgCluster(Cluster<HTFunArg>) from Cluster<HTFunArg>{
  @:noUsing static public function lift(self:Cluster<HTFunArg>){
    return new HTFunArgCluster(self);
  }
  public function new(self) this = self;
  
  @:from static public function fromArray(self:Array<HTFunArg>){
    return lift(Cluster.lift(self));
  }
} 