Assets {
  Id: 3939939384987932005
  Name: "Shared Material Race Track Dirt Enviroment"
  PlatformAssetType: 13
  SerializationVersion: 125
  CustomMaterialAsset {
    BaseMaterialId: 4281430000640660090
    ParameterOverrides {
      Overrides {
        Name: "cmp:Top"
        AssetReference {
          Id: 15168255502350012178
        }
      }
      Overrides {
        Name: "top_scale"
        Float: 1
      }
      Overrides {
        Name: "cmp:Sides"
        AssetReference {
          Id: 14643090495247569259
        }
      }
      Overrides {
        Name: "direction"
        Bool: true
      }
    }
    Assets {
      Id: 4281430000640660090
      Name: "Composite Triplanar Blend"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_composite_triplanar_wa"
      }
    }
    Assets {
      Id: 15168255502350012178
      Name: "Forest Floor 01"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "forest-floor_001"
      }
    }
    Assets {
      Id: 14643090495247569259
      Name: "Dirt 01"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "dirt_001"
      }
    }
  }
}
