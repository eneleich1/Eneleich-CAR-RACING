Assets {
  Id: 1432976411988535106
  Name: "Shared Material Race Track Dirt Road"
  PlatformAssetType: 13
  SerializationVersion: 125
  CustomMaterialAsset {
    BaseMaterialId: 14582790818618070150
    ParameterOverrides {
      Overrides {
        Name: "cmp:Material1"
        AssetReference {
          Id: 14643090495247569259
        }
      }
      Overrides {
        Name: "cmp:Material2"
        AssetReference {
          Id: 2597203560731079473
        }
      }
      Overrides {
        Name: "cmpc:Material2"
        Color {
          R: 0.749
          G: 0.473244905
          B: 0.18
          A: 1
        }
      }
      Overrides {
        Name: "blend_amount"
        Float: 0.530389607
      }
      Overrides {
        Name: "material2_scale"
        Float: 2
      }
      Overrides {
        Name: "cmpc:Material1"
        Color {
          R: 0.781
          G: 0.781
          B: 0.781
          A: 1
        }
      }
      Overrides {
        Name: "color"
        Color {
          R: 2
          G: 1.15502501
          B: 0.48999989
          A: 1
        }
      }
    }
    Assets {
      Id: 14582790818618070150
      Name: "Asphalt 01"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_gen_asphault_001"
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
    Assets {
      Id: 2597203560731079473
      Name: "Rocky Ground 01"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "rocky_001"
      }
    }
  }
}
