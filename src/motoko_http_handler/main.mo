import HashMap = "mo:base/HashMap";
import Blob = "mo:base/Blob";
import Text "mo:base/Text";
import Option "mo:base/Option";

actor {

    public type HttpRequest = {
        body: Blob;
        headers: [HeaderField];
        method: Text;
        url: Text;
    };

    public type StreamingCallbackToken =  {
        content_encoding: Text;
        index: Nat;
        key: Text;
        sha256: ?Blob;
    };
    public type StreamingCallbackHttpResponse = {
        body: Blob;
        token: ?StreamingCallbackToken;
    };
    public type ChunkId = Nat;
    public type SetAssetContentArguments = {
        chunk_ids: [ChunkId];
        content_encoding: Text;
        key: Key;
        sha256: ?Blob;
    };
    public type Path = Text;
    public type Key = Text;

    public type HttpResponse = {
        body: Blob;
        headers: [HeaderField];
        status_code: Nat16;
        streaming_strategy: ?StreamingStrategy;
    };

    public type StreamingStrategy = {
        #Callback: {
            callback: query (StreamingCallbackToken) ->
            async (StreamingCallbackHttpResponse);
            token: StreamingCallbackToken;
        };
    };

    public type HeaderField = (Text, Text);

    private func removeQuery(str: Text): Text {
        return Option.unwrap(Text.split(str, #char '?').next());
    };

    public query func http_request(req: HttpRequest): async (HttpResponse) {
        let path = removeQuery(req.url);
        
        if(path == "/") {
            return {
                body = Text.encodeUtf8("root page :" # path);
                headers = [];
                status_code = 200;
                streaming_strategy = null;
            };
        };

        if(path == "/metrics") {
            return {
                body = Text.encodeUtf8("Metrics page :"  # path);
                headers = [];
                status_code = 200;
                streaming_strategy = null;
            };
        };

        if(path == "/big_file") {
            // TODO: example of response with streaming_strategy
            // that returns a large file in streaming mode
        };


        return {
            body = Text.encodeUtf8("404 Not found :" # path);
            headers = [];
            status_code = 404;
            streaming_strategy = null;
        };
    };
};
