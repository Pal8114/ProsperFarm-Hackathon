import Map "mo:base/HashMap";
import Text "mo:base/Text";

// 游戏资产模块
module {

    // 简单的玩家结构，目前保存账号UID与金币和钻石
    public type Person = {
        uid : Text;
        var coin: Nat;
        var gem : Nat;
        var json: Text;
    };
    
};