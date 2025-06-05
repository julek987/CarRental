package WPFAT.service.interfaces;

import WPFAT.model.PickupLocation;

import java.util.List;


public interface PickupLocationService {

    public List<PickupLocation> getAllActiveLocations();
    public PickupLocation getById(Long id);
}
