package com.xoa.global.jsondate;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.xoa.util.DateFormat;

import java.util.Date;

/**
 * Created by eagle on 2017/5/25.
 */
public class DateSerializerHMS extends JsonSerializer<Date> {
    @Override
    public void serialize(Date o, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) {

            try{
               String date= DateFormat.getFormatByUse("HH:mm:ss",o);
                jsonGenerator.writeString(date);
            }catch (Exception e){
                e.printStackTrace();
            }


    }
}
