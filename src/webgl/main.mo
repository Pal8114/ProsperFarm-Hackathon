import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Token "canister:Token";
import Bool "mo:base/Bool";
import List "mo:base/List";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Asset "asset";

actor Main {

    public type Subaccount = Blob;
    public type Tokens = Nat;
    public type Memo = Blob;
    public type Timestamp = Nat64;
    private stable var owner_ : Principal = Principal.fromText("xxxxx-xxxxx-xxxxx-xxxxx-xxxxx-xxxxx-xxxxx-xxxxx-xxxxx-xxxxx-xxx");

    // game uid and saved
    type Person = Asset.Person;
    var saved : List.List<Person> = List.nil();

    // register
    public func register(n : Principal) : async Text {
        var uid : Text = Principal.toText(n);
        let p: ?Person = List.find<Person>(saved, func(p : Person) : Bool { p.uid == uid });
        switch p {
            case null {
            saved := List.push(
                {
                    uid = uid;
                    var coin = 0;
                    var gem = 0;
                    var json = "{}";
                }, saved);
            };
            case (?p) {};
        };
        uid;
    };

    // push
    public func push(uid : Text, json : Text) : async() {
        let p: ?Person = List.find<Person>(saved, func(p : Person) : Bool { p.uid == uid });
        switch p {
            case null {};
            case (?p) {
                p.json := json;
            };
        };
    };
    
    // pull
    public func pull(uid : Text) : async Text {
        var json : Text = "{}";
        let p: ?Person = List.find<Person>(saved, func(p : Person) : Bool { p.uid == uid });
        switch p {
            case null {};
            case (?p) {
                json := p.json;
            };
        };
        json;
    };

    // Get the principal owner
    public query func get() : async Principal {
        return owner_;
    };

    // Set the principal owner
    public func set(n : Principal) : async () {
        var owner : Principal = n;
        owner_ := owner;
    };

    public func transferToken({

        _from : Text;
        _to : Text;
        amount : Tokens;
    }) : async Bool {
        var from : Principal = Principal.fromText(_from);
        var to : Principal = Principal.fromText(_to);
        if (owner_ != from) {
            return false;
        };

        let from_subaccount = null;
        let fee = null;
        let memo = null;
        let created_at_time = null;

        let res = await Token.icrc1_transfer({
            from_subaccount;
            from;
            to;
            amount;
            fee;
            memo;
            created_at_time;
        });
        return true;
    };

};
