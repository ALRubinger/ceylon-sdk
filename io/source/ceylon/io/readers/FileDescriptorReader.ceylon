import ceylon.io { FileDescriptor }
import ceylon.io.buffer { ByteBuffer }

shared class FileDescriptorReader(FileDescriptor fileDescriptor, Integer? length = null) satisfies Reader {
    
    variable Integer position := 0;
    
    shared actual Integer read(ByteBuffer buffer) {
        if(exists length){
            // check that we didn't already read it all
            if(position == length){
                return -1;
            }
            // maybe decrease the max to read from the buffer if required
            Integer remaining = length - position;
            if(buffer.available > remaining){
                buffer.limit := buffer.position + remaining;
            }
        }
        Integer r = fileDescriptor.read(buffer);
        if(r == -1){
            return r;
        }
        position += r;
        return r;
    }
}