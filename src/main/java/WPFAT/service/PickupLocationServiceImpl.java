package WPFAT.service;

import WPFAT.model.PickupLocation;
import WPFAT.repository.PickupLocationRepository;
import WPFAT.service.interfaces.PickupLocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PickupLocationServiceImpl implements PickupLocationService {

    private final PickupLocationRepository pickupLocationRepository;

    @Autowired
    public PickupLocationServiceImpl(PickupLocationRepository pickupLocationRepository) {
        this.pickupLocationRepository = pickupLocationRepository;
    }

    public List<PickupLocation> getAllActiveLocations() {
        return pickupLocationRepository.findByIsActiveTrue();
    }

    public PickupLocation getById(Long id) {
        return pickupLocationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pickup location not found"));
    }
}