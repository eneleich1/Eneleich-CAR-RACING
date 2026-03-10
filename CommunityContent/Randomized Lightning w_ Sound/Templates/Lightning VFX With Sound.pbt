Assets {
  Id: 1853727103652552141
  Name: "Lightning VFX With Sound"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 15158308801148145980
      Objects {
        Id: 15158308801148145980
        Name: "Lightning VFX With Sound"
        Transform {
          Scale {
            X: 8
            Y: 8
            Z: 8
          }
        }
        ParentId: 178010034303884563
        ChildIds: 14525626786114817794
        ChildIds: 7586001628153140508
        ChildIds: 7043138373699416892
        ChildIds: 6047557054007234367
        ChildIds: 14496338973641985340
        ChildIds: 14569055475507566914
        ChildIds: 6422410358081136613
        UnregisteredParameters {
          Overrides {
            Name: "bp:Lightning Shape"
            Int: 1
          }
          Overrides {
            Name: "bp:Loop"
            Bool: false
          }
          Overrides {
            Name: "bp:Flash Value"
            Float: 1
          }
          Overrides {
            Name: "bp:Lightning Style"
            Int: 3
          }
          Overrides {
            Name: "bp:Randomize Shape"
            Bool: true
          }
          Overrides {
            Name: "bp:Scale Low"
            Float: 0.565153658
          }
          Overrides {
            Name: "bp:Scale High"
            Float: 1.2263515
          }
          Overrides {
            Name: "bp:Jitter Speed"
            Float: 0.680177212
          }
          Overrides {
            Name: "bp:Erosion Speed"
            Float: 0.162573099
          }
          Overrides {
            Name: "bp:Emissive Boost"
            Float: 20
          }
          Overrides {
            Name: "bp:Secondary Flash Brightness"
            Float: 40
          }
          Overrides {
            Name: "bp:Flash Duration"
            Float: 0.0591980964
          }
          Overrides {
            Name: "bp:Onset Duration"
            Float: 0.203181177
          }
          Overrides {
            Name: "bp:Fade Value"
            Float: 0
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Blueprint {
          BlueprintAsset {
            Id: 4061523298365537124
          }
          TeamSettings {
          }
          Vfx {
          }
        }
        Relevance {
          Value: "mc:edistancerelevance:high"
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 14525626786114817794
        Name: "Play"
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
        ParentId: 15158308801148145980
        UnregisteredParameters {
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_1"
            ObjectReference {
              SubObjectId: 14569055475507566914
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_2"
            ObjectReference {
              SubObjectId: 14496338973641985340
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_3"
            ObjectReference {
              SubObjectId: 6047557054007234367
            }
          }
          Overrides {
            Name: "cs:ThunderClose"
            ObjectReference {
              SubObjectId: 7043138373699416892
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
            Id: 6804254584483468958
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 7586001628153140508
        Name: "README_1"
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
        ParentId: 15158308801148145980
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
            Id: 6089752952712408169
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 7043138373699416892
        Name: "Thunder Close"
        Transform {
          Location {
            X: 308.479431
            Y: -3.97012118e-05
            Z: 96.8867493
          }
          Rotation {
            Pitch: 84.9996948
            Yaw: -179.999878
            Roll: -179.999878
          }
          Scale {
            X: 0.75
            Y: 9.25000286
            Z: 3.375
          }
        }
        ParentId: 15158308801148145980
        UnregisteredParameters {
          Overrides {
            Name: "bp:Type"
            Enum {
              Value: "mc:esfx_thunder:27"
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_1"
            ObjectReference {
              SubObjectId: 14569055475507566914
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_2"
            ObjectReference {
              SubObjectId: 14496338973641985340
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_3"
            ObjectReference {
              SubObjectId: 6047557054007234367
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_4"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:ThunderClose"
            ObjectReference {
              SubObjectId: 7043138373699416892
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
        Blueprint {
          BlueprintAsset {
            Id: 11386117978447059772
          }
          TeamSettings {
          }
          AudioBP {
            Volume: 4
            Falloff: 3600
            Radius: 400
            EnableOcclusion: true
            IsSpatializationEnabled: true
            IsAttenuationEnabled: true
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 6047557054007234367
        Name: "Nature Thunder Clap Boom Set 01 SFX"
        Transform {
          Location {
            X: 892.991211
            Y: -457.117279
            Z: -3359.96582
          }
          Rotation {
            Pitch: 84.9996948
            Yaw: -179.999878
            Roll: -179.999878
          }
          Scale {
            X: 0.75
            Y: 9.25000286
            Z: 3.375
          }
        }
        ParentId: 15158308801148145980
        UnregisteredParameters {
          Overrides {
            Name: "bp:Type"
            Enum {
              Value: "mc:esfx_thunder:23"
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_1"
            ObjectReference {
              SubObjectId: 14569055475507566914
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_2"
            ObjectReference {
              SubObjectId: 14496338973641985340
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_3"
            ObjectReference {
              SubObjectId: 6047557054007234367
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_4"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:ThunderClose"
            ObjectReference {
              SubObjectId: 7043138373699416892
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
        Blueprint {
          BlueprintAsset {
            Id: 11386117978447059772
          }
          TeamSettings {
          }
          AudioBP {
            Volume: 1.81310749
            Falloff: 3600
            Radius: 20000
            EnableOcclusion: true
            IsSpatializationEnabled: true
            IsAttenuationEnabled: true
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 14496338973641985340
        Name: "Nature Thunder Clap Boom Set 01 SFX"
        Transform {
          Location {
            X: 344.544922
            Y: -1368.74988
            Z: -97.3416443
          }
          Rotation {
            Pitch: 84.9996948
            Yaw: -179.999878
            Roll: -179.999878
          }
          Scale {
            X: 0.75
            Y: 9.25000286
            Z: 3.375
          }
        }
        ParentId: 15158308801148145980
        UnregisteredParameters {
          Overrides {
            Name: "bp:Type"
            Enum {
              Value: "mc:esfx_thunder:23"
            }
          }
          Overrides {
            Name: "bp:Start Delay Min (Seconds)"
            Float: 1
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_1"
            ObjectReference {
              SubObjectId: 14569055475507566914
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_2"
            ObjectReference {
              SubObjectId: 14496338973641985340
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_3"
            ObjectReference {
              SubObjectId: 6047557054007234367
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_4"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:ThunderClose"
            ObjectReference {
              SubObjectId: 7043138373699416892
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
        Blueprint {
          BlueprintAsset {
            Id: 11386117978447059772
          }
          TeamSettings {
          }
          AudioBP {
            Volume: 0.722242236
            Falloff: 3600
            Radius: 15000
            EnableOcclusion: true
            IsSpatializationEnabled: true
            IsAttenuationEnabled: true
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 14569055475507566914
        Name: "Nature Thunder Clap Boom Set 01 SFX"
        Transform {
          Location {
            X: 401.891357
            Y: 1521.49939
            Z: 1252.92554
          }
          Rotation {
            Pitch: 84.9996948
            Yaw: -179.999878
            Roll: -179.999878
          }
          Scale {
            X: 0.75
            Y: 9.25000286
            Z: 3.375
          }
        }
        ParentId: 15158308801148145980
        UnregisteredParameters {
          Overrides {
            Name: "bp:Type"
            Enum {
              Value: "mc:esfx_thunder:23"
            }
          }
          Overrides {
            Name: "bp:Start Delay Min (Seconds)"
            Float: 1
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_1"
            ObjectReference {
              SubObjectId: 14569055475507566914
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_2"
            ObjectReference {
              SubObjectId: 14496338973641985340
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_3"
            ObjectReference {
              SubObjectId: 6047557054007234367
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_4"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:ThunderClose"
            ObjectReference {
              SubObjectId: 7043138373699416892
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
        Blueprint {
          BlueprintAsset {
            Id: 11386117978447059772
          }
          TeamSettings {
          }
          AudioBP {
            Volume: 0.410566419
            Falloff: 3600
            Radius: 15000
            EnableOcclusion: true
            IsAttenuationEnabled: true
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 6422410358081136613
        Name: "Nature Thunder Clap Boom Set 01 SFX"
        Transform {
          Location {
            X: 436.750122
            Y: 564.625061
            Z: -1927.14172
          }
          Rotation {
            Pitch: 84.9996948
            Yaw: -179.999878
            Roll: -179.999878
          }
          Scale {
            X: 0.75
            Y: 9.25000286
            Z: 3.375
          }
        }
        ParentId: 15158308801148145980
        UnregisteredParameters {
          Overrides {
            Name: "bp:Type"
            Enum {
              Value: "mc:esfx_thunder:23"
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_1"
            ObjectReference {
              SubObjectId: 14569055475507566914
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_2"
            ObjectReference {
              SubObjectId: 14496338973641985340
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_3"
            ObjectReference {
              SubObjectId: 6047557054007234367
            }
          }
          Overrides {
            Name: "cs:NatureThunderClapBoomSet01SFX_4"
            ObjectReference {
              SubObjectId: 6422410358081136613
            }
          }
          Overrides {
            Name: "cs:ThunderClose"
            ObjectReference {
              SubObjectId: 7043138373699416892
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
        Blueprint {
          BlueprintAsset {
            Id: 11386117978447059772
          }
          TeamSettings {
          }
          AudioBP {
            Volume: 1.30106866
            Falloff: 3600
            Radius: 20000
            EnableOcclusion: true
            IsSpatializationEnabled: true
            IsAttenuationEnabled: true
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
    }
    Assets {
      Id: 4061523298365537124
      Name: "Lightning VFX"
      PlatformAssetType: 8
      PrimaryAsset {
        AssetType: "VfxBlueprintAssetRef"
        AssetId: "fxbp_lightning"
      }
    }
    Assets {
      Id: 11386117978447059772
      Name: "Nature Thunder Clap Boom Set 01 SFX"
      PlatformAssetType: 10
      PrimaryAsset {
        AssetType: "AudioBlueprintAssetRef"
        AssetId: "sfxabp_thunder_ref"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  Marketplace {
    Description: "Randomized lightning system with sound\r\n\r\nMake sure to look at the README."
  }
  SerializationVersion: 125
  DirectlyPublished: true
}
