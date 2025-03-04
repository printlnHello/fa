-- File     :  /cdimage/units/UAB1303/UAB1303_script.lua
-- Author(s):  Jessica St. Croix, David Tomandl, John Comes
-- Summary  :  Aeon T3 Mass Fabricator
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
-------------------------------------------------------------------
local AMassFabricationUnit = import("/lua/aeonunits.lua").AMassFabricationUnit

-- upvalue for perfomance
local CreateRotator = CreateRotator
local Random = Random
local TrashBagAdd = TrashBag.Add


---@class UAB1303 : AMassFabricationUnit
UAB1303 = ClassUnit(AMassFabricationUnit) {

    OnStopBeingBuilt = function(self, builder, layer)
        AMassFabricationUnit.OnStopBeingBuilt(self, builder, layer)
        local num = self:GetRandomDir()
        local trash = self.Trash
        self.RingManip1 = CreateRotator(self, 'B01', 'x', nil, 0, 15, 45)
        TrashBagAdd(trash, self.RingManip1)
        self.RingManip2 = CreateRotator(self, 'B02', '-x', nil, 0, 15, 45)
        TrashBagAdd(trash, self.RingManip2)
        self.BallManip = CreateRotator(self, 'B03', 'y', nil, 0, 15, 80 + Random(0, 20) * num)
        TrashBagAdd(trash, self.BallManip)
        self.ParentManip1 = CreateRotator(self, 'B04', 'z', nil, 0, 15, 80 + Random(0, 20) * num)
        TrashBagAdd(trash, self.ParentManip1)
        self.ParentManip2 = CreateRotator(self, 'B04', 'y', nil, 0, 15, 80 + Random(0, 20) * num)
        TrashBagAdd(trash, self.ParentManip2)
        self.ParentManip3 = CreateRotator(self, 'B04', 'x', nil, 0, 15, 80 + Random(0, 20) * num)
        TrashBagAdd(trash, self.ParentManip3)
    end,

    OnProductionPaused = function(self)
        AMassFabricationUnit.OnProductionPaused(self)
        local num = self:GetRandomDir()
        self.RingManip1:SetSpinDown(true)
        self.RingManip2:SetSpinDown(true)
        self.BallManip:SetSpinDown(true)
        self.BallManip:SetTargetSpeed(80 + Random(0, 20) * num)
        self.ParentManip1:SetSpinDown(true)
        self.ParentManip1:SetTargetSpeed(80 + Random(0, 20) * num)
        self.ParentManip2:SetSpinDown(true)
        self.ParentManip2:SetTargetSpeed(80 + Random(0, 20) * num)
        self.ParentManip3:SetSpinDown(true)
        self.ParentManip3:SetTargetSpeed(80 + Random(0, 20) * num)
    end,
    
    OnProductionUnpaused = function(self)
        AMassFabricationUnit.OnProductionUnpaused(self)
        self.RingManip1:SetSpinDown(false)
        self.RingManip2:SetSpinDown(false)
        self.BallManip:SetSpinDown(false)
        self.ParentManip1:SetSpinDown(false)
        self.ParentManip2:SetSpinDown(false)
        self.ParentManip3:SetSpinDown(false)
    end,


    GetRandomDir = function(self)
        local num = Random(0, 2)
        if num > 1 then
            return 1
        end
        return -1
    end,
}

TypeClass = UAB1303