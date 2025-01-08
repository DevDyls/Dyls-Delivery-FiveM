<h1 align="center">🚚 FiveM Delivery Script</h1>
<p align="center">
    A custom delivery script for FiveM roleplay servers that adds immersive job-based activities. Deliver parcels, drive courier-specific vehicles, and earn rewards in this feature-rich system.
</p>

---

## 📦 Features
<ul>
    <li>✅ <strong>Random Delivery Locations:</strong> Assigns players random delivery addresses across the map.</li>
    <li>✅ <strong>Waypoint System:</strong> Automatically sets a waypoint for the delivery destination.</li>
    <li>✅ <strong>Delivery Blip:</strong> Visible map marker for the delivery destination.</li>
    <li>✅ <strong>Vehicle Restriction:</strong> Only specific delivery vehicles can be used for the job.</li>
    <li>✅ <strong>Payment System:</strong> Players receive a cash reward after successful delivery.</li>
    <li>✅ <strong>On Duty/Off Duty Toggle:</strong> Players can toggle their availability for delivery jobs through the menu.</li>
    <li>✅ <strong>Force Delivery:</strong> Manually trigger a delivery via the menu.</li>
    <li>✅ <strong>Automatic Deliveries:</strong> Deliveries are assigned automatically while on duty.</li>
    <li>✅ <strong>Custom Courier Vehicles:</strong> Each courier comes with its own vehicles and liveries.</li>
</ul>

---

## 🎮 How to Use
<h3>🚚 Starting a Delivery Job</h3>
<ol>
    <li><strong>Toggle Duty Status:</strong> 
        <ul>
            <li>Press <code>F9</code> to open the menu.</li>
            <li>Select "Toggle Duty Status" to go on or off duty.</li>
        </ul>
    </li>
    <li><strong>Spawn a Vehicle:</strong> 
        <ul>
            <li>Use the menu to spawn a courier-specific vehicle with the correct livery.</li>
        </ul>
    </li>
    <li><strong>Receive a Delivery:</strong> 
        <ul>
            <li>While on duty, deliveries are assigned automatically every 5 minutes.</li>
            <li>A waypoint and blip will appear on the map when a delivery is ready.</li>
        </ul>
    </li>
    <li><strong>Force Delivery:</strong> 
        <ul>
            <li>If you want a delivery immediately, select "Force Delivery" from the menu.</li>
        </ul>
    </li>
</ol>

<h3>📦 Completing the Delivery</h3>
<ol>
    <li><strong>Drive to the Destination:</strong> 
        <ul>
            <li>Follow the waypoint to the delivery location marked by a green blip.</li>
        </ul>
    </li>
    <li><strong>Delivery Confirmation:</strong> 
        <ul>
            <li>Enter the marker zone to complete the delivery.</li>
        </ul>
    </li>
    <li><strong>Receive Payment:</strong> 
        <ul>
            <li>Upon successful delivery, a notification will show your earnings.</li>
        </ul>
    </li>
</ol>

---

## ⚙️ Configuration

<h3>Delivery Locations</h3>
<p>Edit the <code>deliveryLocations</code> table in <code>client.lua</code> to customize delivery points:</p>




```lua
local deliveryLocations = {
    {x = 1157.0, y = -331.0, z = 68.0}, -- Mirror Park Fuel Station (411)
    {x = 1302.0, y = -528.0, z = 71.0}, -- Nikola Pl, Mirror Park, ()
    {x = 1301.0, y = -573.0, z = 71.0}, -- Nikola Pl, Mirror Park, ()
    {x = 906.0, y = -491.0, z = 59.0}, -- West Mirror Drive, Mirror Park, ()
    {x = 1154.0, y = -776.0, z = 57.0}, -- West Mirror Drive, Mirror Park, (424)
    {x = -14.0, y = -1442.0, z = 31.0}, -- Forum Drive, Strawberry, (127)
    {x = 85.0, y = -1958.0, z = 21.0}, -- Grove Street, Davis, ()
    {x = 1375.0, y = -586.0, z = 74.0}, -- Nikola Pl, Mirror Park, 444
    {x = 1197.0, y = -3099.0, z = 5.0}, -- LS Ports (18)
    {x = -376.0, y = -1874.0, z = 20.0}, -- Maze Bank Arena (88)
    {x = 1275.0, y = -1721.0, z = 54.0}, -- Armadillo Vista (184)
    {x = 86.0, y = -1390.0, z = 29.0} -- Innocence Boulevard (134)
}

local courierOptions = {
    {
        name = "DPD",
        vehicles = {
            {model = "RUMPO", livery = 4},
            {model = "RUMPO3", livery = 0}
        }
    },
    {
        name = "Waitrose",
        vehicles = {
            {model = "MULE3", livery = 0}
        }
    },
    {
        name = "Amazon Prime",
        vehicles = {
            {model = "POUNDER", livery = 0},
            {model = "PONY", livery = 0}
        }
    },
    {
        name = "Royal Mail",
        vehicles = {
            {model = "PONY2", livery = 0},
            {model = "RUMPO", livery = 3}
        }
    },
    {
        name = "Tesco",
        vehicles = {
            {model = "MULE2", livery = 0},
            {model = "MULE", livery = 0}
        }
    },
    {
        name = "Argos",
        vehicles = {
            {model = "BOXVILLE", livery = 3}
        }
    }
}
```

<h3 align="center">📽️ Showcase</h3>
<p align="center"> <a href="https://youtu.be/wZFzSKlta9U">General Overview</a> | <a href="https://youtu.be/zHI5RbKSxYc">Permissions and Testing</a> </p> ```
<p align="center">please do not claim this as your's, do not resell as it is free, anyone can find this.</p>
