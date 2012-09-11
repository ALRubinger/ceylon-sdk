doc "Abstract class for [[Decoder]] objects, which abstracts
     the [[StringBuilder]]."
abstract class AbstractDecoder() satisfies Decoder {
    
    // FIXME: this shouldn't really be exposed, should it?
    shared StringBuilder builder = StringBuilder();

    shared actual String? consumeAvailable() {
        // consume all we have without checking for missing things
        if(builder.size > 0){
            value ret = builder.string;
            builder.reset();
            return ret;
        }else{
            return null;
        }
    }
    
    default shared actual String done() {
        value ret = builder.string;
        builder.reset();
        return ret;
    }
}