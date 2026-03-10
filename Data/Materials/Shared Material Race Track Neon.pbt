Assets {
  Id: 17440389046382511980
  Name: "Shared Material Race Track Neon"
  PlatformAssetType: 13
  SerializationVersion: 125
  CustomMaterialAsset {
    BaseMaterialId: 14898661629175220867
    ParameterOverrides {
      Overrides {
        Name: "oncolor"
        Color {
          G: 0.0956953391
          B: 0.169999957
          A: 1
        }
      }
      Overrides {
        Name: "enable animation"
        Bool: false
      }
      Overrides {
        Name: "framenumber"
        Int: 1
      }
      Overrides {
        Name: "animation type"
        Int: 3
      }
    }
    Assets {
      Id: 14898661629175220867
      Name: "Animated Neon Sign "
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "fxmi_NeonSign_All"
      }
    }
  }
}
