package com.lyles.service;

import org.springframework.stereotype.Service;
import com.lyles.config.PayConfig;
import java.util.ArrayList;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Service
public class SubscribeService {
    public ArrayList<PayConfig.ServiceConfig> FindAllAvailableService(){
        ArrayList<PayConfig.ServiceConfig> AvailableServiceList = PayConfig.SERVICES.values().stream()
        .filter(s -> Boolean.TRUE.equals(s.getEnabled()))
        .collect(Collectors.toCollection(ArrayList::new));

        return AvailableServiceList;
    }
}
