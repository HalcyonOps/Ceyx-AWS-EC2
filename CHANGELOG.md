# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2024-03-XX

### Added - Infrastructure

- EBS optimization enabled by default with GP3 volumes
- IOPS (3000) and throughput (125) settings for GP3 root volumes
- Instance type validation for EBS-optimized compatibility
- Security level and backup policy variables with validation
- Integration tests for EBS optimization verification
- Standardized tag structure across all resources
- Automatic recovery settings for instance maintenance

### Changed - Configuration

- Updated root volume configurations across all instance types
- Standardized instance configurations (dedicated, spot, capacity)
- Enhanced metadata options for improved security (IMDSv2)
- Improved lifecycle policies and resource timeouts
- Updated documentation with new configuration options
- Unified volume configurations across instance types

### Fixed - Consistency

- Consistent EBS optimization across all instance types
- Standardized delete_on_termination settings for volumes
- Unified tag structure for root and additional volumes
- Normalized instance metadata configuration
- Standardized resource naming conventions

### Security - Enhancements

- Enforced IMDSv2 for enhanced metadata security
- Added security level classifications
- Implemented backup policy controls
- Standardized encryption settings across all volumes
- Enhanced instance profile configurations

### Performance - Optimizations

- Optimized GP3 volume configurations
- Enhanced EBS throughput settings
- Improved instance recovery options
- Standardized monitoring configurations

## [1.0.0] - 2024-03-XX

Initial release with basic EC2 functionality
