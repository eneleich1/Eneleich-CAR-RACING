Assets {
  Id: 6904842682975640316
  Name: "Ranked Nameplates"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 16867722402634252863
      Objects {
        Id: 16867722402634252863
        Name: "Ranked Nameplates"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 2791520649633765814
        ChildIds: 16947353618633050170
        UnregisteredParameters {
          Overrides {
            Name: "cs:ShowOnSelf"
            Bool: false
          }
          Overrides {
            Name: "cs:RankColor"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "cs:NameColor"
            Color {
              G: 0.291920125
              B: 0.76
              A: 1
            }
          }
          Overrides {
            Name: "cs:MaxDistanceToShowRank"
            Float: 12000
          }
          Overrides {
            Name: "cs:MaxDistanceToShowName"
            Float: 5000
          }
          Overrides {
            Name: "cs:Scale"
            Float: 2
          }
          Overrides {
            Name: "cs:MaxDistanceToShowRank:tooltip"
            String: "Only show rank up to this distance away. 0 means always show them."
          }
          Overrides {
            Name: "cs:MaxDistanceToShowName:tooltip"
            String: "Only show player names up to this distance away. 0 means always show them."
          }
          Overrides {
            Name: "cs:Scale:tooltip"
            String: "Overall scale factor for nameplates."
          }
          Overrides {
            Name: "cs:ShowOnSelf:tooltip"
            String: "Show a nameplate on the local player."
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
        Id: 16947353618633050170
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
        ParentId: 16867722402634252863
        ChildIds: 6845531121077774645
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
        Id: 6845531121077774645
        Name: "NameplatesRankedControllerClient"
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
        ParentId: 16947353618633050170
        UnregisteredParameters {
          Overrides {
            Name: "cs:ComponentRoot"
            ObjectReference {
              SubObjectId: 16867722402634252863
            }
          }
          Overrides {
            Name: "cs:NameplateTemplate"
            AssetReference {
              Id: 16763629220550616089
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
            Id: 12314395121783933783
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
