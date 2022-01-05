#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error
set -e

../bin/cryptogen generate --config=./crypto-config.yaml

mkdir channel-artifacts && export FABRIC_CFG_PATH=$PWD

../bin/configtxgen -profile SampleMultiNodeEtcdRaft -outputBlock ./channel-artifacts/genesis.block -channelID orderer-system-channel

export CHANNEL_ONE_NAME=channel12
export CHANNEL_ONE_PROFILE=Channel12
export CHANNEL_TWO_NAME=channel13
export CHANNEL_TWO_PROFILE=Channel13
export CHANNEL_THREE_NAME=channel14
export CHANNEL_THREE_PROFILE=Channel14



../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME

../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME

../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME



../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org1MSP

../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org2MSP



../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg Org1MSP

../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg Org3MSP


../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg Org1MSP

../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg Org4MSP

