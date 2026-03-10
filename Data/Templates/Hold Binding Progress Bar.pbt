Assets {
  Id: 17425035826126763228
  Name: "Hold Binding Progress Bar"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 10791704124187171466
      Objects {
        Id: 10791704124187171466
        Name: "Hold Binding Progress Bar"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 6921449276133104819
        ChildIds: 6633773734409432575
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
        Control {
          Width: 200
          Height: 60
          RotationAngle: -90
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          StatBar {
            Color {
              R: 1
              G: 1
              B: 1
              A: 0.3
            }
            BackgroundColor {
            }
            FillBrush {
            }
            BackgroundBrush {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 6633773734409432575
        Name: "HoldBindingEventProgressBarClient"
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
        ParentId: 10791704124187171466
        UnregisteredParameters {
          Overrides {
            Name: "cs:ProgressBar"
            ObjectReference {
              SubObjectId: 10791704124187171466
            }
          }
          Overrides {
            Name: "cs:Binding"
            String: "ability_extra_40"
          }
          Overrides {
            Name: "cs:HoldDuration"
            Float: 1
          }
          Overrides {
            Name: "cs:BroadcastEvent"
            String: ""
          }
          Overrides {
            Name: "cs:BroadcastServerEvent"
            String: "RestorePlayerOnTrack"
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
            Id: 11858922264784307049
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
