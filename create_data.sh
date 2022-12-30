#!/bin/bash 
# run by ./Master.sh
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest
# echo "Select laz tiles"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/copy_laz_tiles.py /workspace/data/footprint.shp /workspace/data/remains_pits.shp /workspace/lidar/pooled_laz_files/ /workspace/data/selected_lidar_tiles_pits/
#echo "Create DEM from laz tiles"
#docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/laz_to_dem.py /workspace/data/selected_lidar_tiles_pits/ /workspace/data/dem_tiles_pits/ 0.5
# echo "Extract and normalize topographical indices"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/Extract_topographcical_indices.py /workspace/temp/ /workspace/data/dem_tiles_pits/ /workspace/data/topographical_indices_normalized_pits/hillshade/ /workspace/data/topographical_indices_normalized_pits/elevation_above_pit/ /workspace/data/topographical_indices_normalized_pits/minimal_curvature/ /workspace/data/topographical_indices_normalized_pits/profile_curvature/ /workspace/data/topographical_indices_normalized_pits/stdon/
# echo "Create segmentation masks"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/create_segmentation_masks.py /workspace/data/dem_tiles_pits/ /workspace/data/remains_pits.shp Classvalue /workspace/data/segmentations_masks_pits/

# echo "empty old directories and creating new ones before splitting"
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/elevation_above_pit/
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/elevation_above_pit/
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/hillshade/
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/hillshade/
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/labels/
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/labels/
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/minimal_curvature/
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/minimal_curvature/
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/profile_curvature/
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/profile_curvature/
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/stdon/
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/split_data_pits/stdon/

echo "Split hillshade"
docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/split_training_data.py /workspace/data/topographical_indices_normalized_pits/hillshade/ /workspace/data/split_data_pits/hillshade/ --tile_size 250
echo "Split elevation_above_pit"
docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/split_training_data.py /workspace/data/topographical_indices_normalized_pits/elevation_above_pit/ /workspace/data/split_data_pits/elevation_above_pit/ --tile_size 250
echo "Split Spherical Std Dev Of Normals"
docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/split_training_data.py /workspace/data/topographical_indices_normalized_pits/stdon/ /workspace/data/split_data_pits/stdon/ --tile_size 250
echo "Split minimal_curvature"
docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/split_training_data.py /workspace/data/topographical_indices_normalized_pits/minimal_curvature/ /workspace/data/split_data_pits/minimal_curvature/ --tile_size 250
echo "Split profile_curvature"
docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/split_training_data.py /workspace/data/topographical_indices_normalized_pits/profile_curvature/ /workspace/data/split_data_pits/profile_curvature/ --tile_size 250
echo "Split labels"
docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/split_training_data.py /workspace/data/segmentation_masks_pits/ /workspace/data/split_data_pits/labels/ --tile_size 250

echo "remove unlabaled chips"
docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/remove_unlabled_chips.py 10 /workspace/data/split_data_pits/labels/ /workspace/data/split_data_pits/hillshade/ /workspace/data/split_data_pits/elevation_above_pit/ /workspace/data/split_data_pits/stdon/ /workspace/data/split_data_pits/minimal_curvature/ /workspace/data/split_data_pits/profile_curvature/
echo "Create training and test split"
docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/create_partition.py /workspace/data/split_data_pits/labels/ /workspace/data/test_chips.csv


# echo "empty old directories and creating new ones before moving test files"
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/elevation_above_pit
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/elevation_above_pit
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/hillshade
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/hillshade
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/labels
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/labels
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/minimal_curvature
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/minimal_curvature
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/profile_curvature
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/profile_curvature
# rm -r /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/stdon
# mkdir /mnt/Extension_100TB/William/Projects/Cultural_remains/data/test_data_pits/stdon

# echo "move test labels to new directories"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/partition_data.py /workspace/data/split_data_pits/labels/ /workspace/data/test_data_pits/labels/ /workspace/data/test_chips.csv
# echo "move test hillshade to new directories"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/partition_data.py /workspace/data/split_data_pits/hillshade/ /workspace/data/test_data_pits/hillshade/ /workspace/data/test_chips.csv
# echo "move test elevation_above_pit to new directories"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/partition_data.py /workspace/data/split_data_pits/elevation_above_pit/ /workspace/data/test_data_pits/elevation_above_pit/ /workspace/data/test_chips.csv
# echo "move test Spherical Std Dev Of Normals to new directories"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/partition_data.py /workspace/data/split_data_pits/stdon/ /workspace/data/test_data_pits/stdon/ /workspace/data/test_chips.csv
# echo "move test minimal_curvature to new directories"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/partition_data.py /workspace/data/split_data_pits/minimal_curvature/ /workspace/data/test_data_pits/minimal_curvature/ /workspace/data/test_chips.csv
# echo "move test profile_curvature to new directories"
# docker run -v /mnt/Extension_100TB/William/GitHub/Remnants-of-charcoal-kilns:/workspace/code -v /mnt/Extension_100TB/William/Projects/Cultural_remains/data:/workspace/data -v /mnt/ramdisk:/workspace/temp -v /mnt/Extension_100TB/national_datasets/laserdataskog:/workspace/lidar segmentation:latest python /workspace/code/tools/partition_data.py /workspace/data/split_data_pits/profile_curvature/ /workspace/data/test_data_pits/profile_curvature/ /workspace/data/test_chips.csv
