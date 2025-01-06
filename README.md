# 🚚 FiveM Delivery Script

A custom **FiveM Delivery Script** for roleplay servers where players are assigned random delivery jobs and must drive to specific in-game addresses to complete deliveries. This script encourages immersive roleplay and job-based activities.

---

## 📦 Features
- ✅ **Random Delivery Locations:** Players are assigned random delivery addresses across the map.
- ✅ **Waypoint System:** Automatically sets a waypoint for the delivery destination.
- ✅ **Delivery Blip:** A visible map marker for the delivery destination.
- ✅ **Vehicle Restriction:** Only specific delivery vehicles can be used for the job.
- ✅ **Payment System:** Players receive a cash reward after successful delivery.


## 🎮 How to Use

### 🚚 Starting a Delivery Job
1. **Enter a Vehicle:**  
   - Ensure you are in an authorized delivery vehicle (e.g., `"mule"`, `"rumpo3"`, `"pony"`).
2. **Start the Job:**  
   - Type `/deliverystart` in the in-game chat to begin a delivery.
3. **Receive a Delivery Location:**  
   - A random delivery destination will be marked on your map with a green blip.
   - A waypoint will automatically be set for the delivery location.

---

### 📦 Completing the Delivery
1. **Drive to the Destination:**  
   - Follow the waypoint to reach the marked delivery location.
2. **Delivery Confirmation:**  
   - Once you arrive within the drop-off radius, a marker will appear.  
   - Enter the marker zone, and the delivery will be marked as complete.
3. **Receive Payment:**  
   - Upon successful delivery, you will be rewarded with in-game cash.

---

### 🚫 Vehicle Restriction
- The delivery script only allows **authorized vehicles**.  
- If you try to start a delivery in an unauthorized vehicle, you will receive a message stating:  

### Ending a Delivery

- just simply do /enddelivery


## 📦 Installation
1. **Download the Script:**
   - Download the ZIP and extract it into your server's `resources` folder.

2. **Configure Vehicles and Locations:**
   - Edit the delivery locations and allowed vehicles in `client.lua`:
   ```lua
   local deliveryLocations = {
       {x = 1157.0, y = -331.0, z = 68.0} --  Fuel Station
       {x = 1375.0, y = -586.0, z = 74.0}, -- Nikola Pl 
       {x = 1197.0, y = -3099.0, z = 5.0}, -- London Gateway
       {x = -376.0, y = -1874.0, z = 20.0,-- Maze Bank Arena
       {x = 1275.0, y = -1721.0, z = 54.0, -- Armadillo Vista
       {x = 86.0, y = -1390.0, z = 29.0}, -- Innocence Boulevard
    -- Add more locations as needed just copy and paste {x = 0, y = 0, z = 0}
   }

   local allowedVehicles = {
   "RUMPO3",
   "MULE3",
   "RUMPO",
   "POUNDER",
   "PONY2",
   "PONY",
   "MULE",
   "MULE2",
   "BOXVILLE"
    -- add more with your own spawncodes if you have other vehicles.
   
   }

## Dyls-Delivery | FiveM Delivery Script

https://youtu.be/wZFzSKlta9U

## Dyls-Delivery | FiveM Delivery Script Perms testing

https://youtu.be/zHI5RbKSxYc


