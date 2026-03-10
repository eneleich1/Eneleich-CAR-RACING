Assets {
  Id: 3285655298570990929
  Name: "Vehicle Global Camera Controller"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 4227155840348948540
      Objects {
        Id: 4227155840348948540
        Name: "Vehicle Global Camera Controller"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 14587631460994942413
        ChildIds: 11729483665891221583
        UnregisteredParameters {
          Overrides {
            Name: "cs:MaxFieldOfView"
            Float: 125
          }
          Overrides {
            Name: "cs:MinFieldOfView"
            Float: 90
          }
          Overrides {
            Name: "cs:MaxVehicleSpeed"
            Float: 6000
          }
          Overrides {
            Name: "cs:Pitch"
            Float: -20
          }
          Overrides {
            Name: "cs:PositionOffset"
            Vector {
              Z: 100
            }
          }
          Overrides {
            Name: "cs:CameraPosition"
            Vector {
              X: 35
              Z: 60
            }
          }
          Overrides {
            Name: "cs:Stiffness"
            Float: 4
          }
          Overrides {
            Name: "cs:LookBackBinding"
            String: "ability_extra_20"
          }
          Overrides {
            Name: "cs:MaxFieldOfView:tooltip"
            String: "Field of view when vehicle is moving at MaxVehicleSpeed."
          }
          Overrides {
            Name: "cs:MinFieldOfView:tooltip"
            String: "Field of view when vehicle is moving at normal speed."
          }
          Overrides {
            Name: "cs:LookBackBinding:tooltip"
            String: "Binding to look behind the vehicle."
          }
          Overrides {
            Name: "cs:MaxVehicleSpeed:tooltip"
            String: "Set the max vehicle speed at which the camera would lerp to MaxFieldOfView."
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Folder {
          IsGroup: true
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 11729483665891221583
        Name: "ClientContext"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4227155840348948540
        ChildIds: 14404092450297636313
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        NetworkContext {
          MinDetailLevel {
            Value: "mc:edetaillevel:low"
          }
          MaxDetailLevel {
            Value: "mc:edetaillevel:ultra"
          }
          IsAllowedForPC: true
          IsAllowedForMobile: true
          IsAllowedForLowMemoryMobile: true
          PCMinDetailLevel {
            Value: "mc:edetaillevel:low"
          }
          PCMaxDetailLevel {
            Value: "mc:edetaillevel:ultra"
          }
          MobileMinDetailLevel {
            Value: "mc:edetaillevel:low"
          }
          MobileMaxDetailLevel {
            Value: "mc:edetaillevel:ultra"
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 14404092450297636313
        Name: "VehicleGlobalCameraControllerClient"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 11729483665891221583
        UnregisteredParameters {
          Overrides {
            Name: "cs:ComponentRoot"
            ObjectReference {
              SubObjectId: 4227155840348948540
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Script {
          ScriptAsset {
            Id: 8701769300035575771
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 125
}
