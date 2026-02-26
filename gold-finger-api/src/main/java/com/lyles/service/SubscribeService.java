package com.lyles.service;

import org.springframework.stereotype.Service;
import com.lyles.config.PayConfig;
import java.util.ArrayList;

@Service
public class SubscribeService {
    public ArrayList<PayConfig.ServiceConfig> FindAllAvailableService(){
        ArrayList<PayConfig.ServiceConfig> AvailableServiceList = new ArrayList<>();
        for(Integer i: PayConfig.IOSAPP){
            PayConfig.ServiceConfig service = PayConfig.SERVICES.get(i);
            if(service != null && Boolean.TRUE.equals(service.getEnabled())){
                AvailableServiceList.add(service);
            }
        }

        return AvailableServiceList;
    }
}
